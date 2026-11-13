# osTicket Help Desk Lab

A self-hosted help desk for my IT home lab. I'm deploying **osTicket** on Ubuntu Server and working realistic Tier 1 tickets end to end: intake, triage, troubleshooting, escalation, and resolution notes.

> **Status: in progress.** This repo holds my build plan, install script, and ticket scenarios. Screenshots and completed ticket write-ups are added as I work through the lab.

## Lab setup

| Component | Details |
|---|---|
| Host | MacBook Pro (Apple Silicon) running UTM |
| Server | `TICKET01` · Ubuntu Server 24.04 LTS |
| Stack | Apache, MySQL, PHP (LAMP) |
| App | osTicket 1.18 |
| Network | Same virtual network as my Active Directory lab (`homelab.local`) |

## What's in this repo

| File | Purpose |
|---|---|
| [`install-osticket.sh`](install-osticket.sh) | Installs the LAMP stack, creates the database, and stages osTicket for the web installer |
| [`ticket-scenarios.md`](ticket-scenarios.md) | 20 realistic tickets I'll submit and work, from lockouts to phishing |
| [`ticket-writeup-template.md`](ticket-writeup-template.md) | The format I use to document each resolved ticket |

## Build plan

1. **Install** the LAMP stack and osTicket with `install-osticket.sh`, then finish the web installer.
2. **Configure the help desk**
   - Departments: *Help Desk (Tier 1)*, *Systems (Tier 2)*, *Accounts*
   - Help topics: Password / Login, Hardware, Printer, Network, Software, Security
   - SLA plans: **High** = respond within 4 hours, **Normal** = 24 hours
   - Agent roles: Tier 1 can reply, assign, and escalate; Tier 2 can close and manage
3. **Work the tickets** in `ticket-scenarios.md`, troubleshooting against my AD lab where possible
4. **Document** each ticket with the write-up template: symptoms, root cause, fix, and time to resolve

## Quick start

```bash
# On a fresh Ubuntu Server 24.04 VM
git clone https://github.com/vincent98zhang-it/osticket-helpdesk-lab.git
cd osticket-helpdesk-lab
chmod +x install-osticket.sh
sudo ./install-osticket.sh
```

Then browse to `http://<server-ip>/setup/` to finish the osTicket web installer, using the database name, user, and password the script prints.

## Skills practiced

Linux server administration · LAMP stack · MySQL · ticket triage and prioritization · SLAs · escalation · technical documentation

## Related

Part of my IT home lab portfolio, alongside an [Active Directory user provisioning script](https://github.com/vincent98zhang-it/ad-user-provisioning).
