#!/usr/bin/env bash
# install-osticket.sh
# Installs Apache, MySQL, PHP and stages osTicket on Ubuntu Server 24.04.
# Finish setup afterwards in the browser at http://<server-ip>/setup/
set -euo pipefail

OST_VERSION="${OST_VERSION:-v1.18.1}"
DB_NAME="osticket"
DB_USER="osticket"
DB_PASS="$(openssl rand -base64 18)"
WEB_ROOT="/var/www/osticket"

if [[ $EUID -ne 0 ]]; then
  echo "Run this script with sudo." >&2
  exit 1
fi

echo "==> Installing Apache, MySQL, PHP and extensions"
apt-get update
DEBIAN_FRONTEND=noninteractive apt-get install -y \
  apache2 mysql-server unzip curl openssl \
  php libapache2-mod-php php-mysql php-imap php-gd php-intl \
  php-apcu php-mbstring php-xml php-zip php-curl

echo "==> Creating database and user"
mysql <<SQL
CREATE DATABASE IF NOT EXISTS ${DB_NAME} CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
CREATE USER IF NOT EXISTS '${DB_USER}'@'localhost' IDENTIFIED BY '${DB_PASS}';
ALTER USER '${DB_USER}'@'localhost' IDENTIFIED BY '${DB_PASS}';
GRANT ALL PRIVILEGES ON ${DB_NAME}.* TO '${DB_USER}'@'localhost';
FLUSH PRIVILEGES;
SQL

echo "==> Downloading osTicket ${OST_VERSION}"
tmp="$(mktemp -d)"
curl -fsSL -o "${tmp}/osticket.zip" \
  "https://github.com/osTicket/osTicket/releases/download/${OST_VERSION}/osTicket-${OST_VERSION}.zip"
unzip -q "${tmp}/osticket.zip" -d "${tmp}"

echo "==> Staging files in ${WEB_ROOT}"
rm -rf "${WEB_ROOT}"
mkdir -p "${WEB_ROOT}"
cp -r "${tmp}/upload/." "${WEB_ROOT}/"
cp "${WEB_ROOT}/include/ost-sampleconfig.php" "${WEB_ROOT}/include/ost-config.php"
chown -R www-data:www-data "${WEB_ROOT}"
chmod 0666 "${WEB_ROOT}/include/ost-config.php"
rm -rf "${tmp}"

echo "==> Configuring Apache"
cat > /etc/apache2/sites-available/osticket.conf <<APACHE
<VirtualHost *:80>
    DocumentRoot ${WEB_ROOT}
    <Directory ${WEB_ROOT}>
        AllowOverride All
        Require all granted
    </Directory>
    ErrorLog \${APACHE_LOG_DIR}/osticket_error.log
    CustomLog \${APACHE_LOG_DIR}/osticket_access.log combined
</VirtualHost>
APACHE
a2dissite 000-default.conf >/dev/null
a2ensite osticket.conf >/dev/null
a2enmod rewrite >/dev/null
systemctl reload apache2

ip_addr="$(hostname -I | awk '{print $1}')"
cat <<DONE

osTicket is staged. Finish setup in your browser:
  http://${ip_addr}/setup/

Database settings for the installer:
  MySQL hostname: localhost
  Database:       ${DB_NAME}
  Username:       ${DB_USER}
  Password:       ${DB_PASS}

Save that password somewhere safe; it is not stored anywhere else.

After the installer finishes, lock things down:
  sudo chmod 0644 ${WEB_ROOT}/include/ost-config.php
  sudo rm -rf ${WEB_ROOT}/setup
DONE
