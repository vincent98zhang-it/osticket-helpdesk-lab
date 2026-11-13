# Ticket Scenarios

Twenty realistic tickets to submit as end users and work as an agent. Each one gets a priority, a help topic, and a write-up using [`ticket-writeup-template.md`](ticket-writeup-template.md).

| # | Subject (as the user writes it) | Help topic | Priority | What I'll practice |
|---|---|---|---|---|
| 1 | "Locked out of my computer" | Password / Login | High | Finding and unlocking a locked AD account, checking the cause |
| 2 | "Forgot my password" | Password / Login | Normal | Identity verification, reset with change at next logon |
| 3 | "New hire starts Monday, needs an account" | Accounts | Normal | Provisioning with my PowerShell script, group membership |
| 4 | "Employee left on Friday" | Accounts | High | Disabling the account, removing groups, moving to `_Disabled` |
| 5 | "H: drive missing after login" | Network | Normal | Group Policy, `gpresult /r`, OU placement |
| 6 | "Cannot find server DC01" | Network | High | DNS settings, `nslookup`, `ipconfig /flushdns` |
| 7 | "No internet on my laptop" | Network | High | IP config, APIPA addresses, DHCP lease renewal |
| 8 | "Wi-Fi keeps dropping" | Network | Normal | Gathering details, driver and power settings |
| 9 | "Printer says offline" | Printer | Normal | Print spooler, queue, connectivity checks |
| 10 | "Printing blank pages" | Printer | Normal | Driver and hardware triage, escalation criteria |
| 11 | "Computer is really slow" | Hardware | Normal | Task Manager, startup apps, disk space |
| 12 | "Second monitor not detected" | Hardware | Normal | Cables, display settings, drivers |
| 13 | "Laptop won't turn on" | Hardware | High | Power troubleshooting, loaner device, escalation |
| 14 | "Need Adobe Reader installed" | Software | Normal | Software request approval, standard installs |
| 15 | "Outlook keeps asking for my password" | Software | Normal | Credential Manager, profile issues |
| 16 | "Excel crashes when I open one file" | Software | Normal | Safe mode, file vs. app isolation |
| 17 | "Suspicious email asking for my password" | Security | High | Phishing identification, reporting, blocking the sender |
| 18 | "I clicked a link in a weird email" | Security | High | Containment steps, password reset, escalation to security |
| 19 | "Need access to the Sales shared folder" | Accounts | Normal | Least privilege, manager approval, group-based access |
| 20 | "Account disabled by mistake" | Accounts | High | Re-enabling, verifying groups, documenting the error |
