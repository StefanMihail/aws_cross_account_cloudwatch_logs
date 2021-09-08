Audit logs
/var/log/audit/audit.log
Suspect that there might have been a security breach in your server? Notice a suspicious javascript file where it shouldn’t be? If so, then find this log file asap!

Investigate failed login attempts
Investigate brute-force attacks and other vulnerabilities related to user authorization mechanism.
======================


Secure logs
/var/log/secure

All user authentication events are logged here.
This log file can provide detailed insight about unauthorized or failed login attempts
Can be very useful to detect possible hacking attempts.
It also stores information about successful logins and tracks the activities of valid users.
======================


Cron logs
/var/log/Cron

Whenever a cron job runs, this log file records all relevant information including successful execution and error messages in case of failures.
If you’re having problems with your scheduled cron, you need to check out this log file.
======================


Yum logs
Track the installation of system components and software packages.
Check the messages logged here to see whether a package was correctly installed or not.
Helps you troubleshoot issues related to software installations.
