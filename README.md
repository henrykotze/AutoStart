# AutoStart
Automatically start your application after it has crashed or hanged

# Notes
..* This was created to be used on the odroid c1+ running Ubuntu Mate. I experienced alot of problems using programs like supervisor and cron to work and satisfy my specification for the application that was supposed to run on it. THis script will work nicely on the Raspberry Pi, even though there is better and more supported programs to be used.

..* One needs to play around with the script, before implementing it straight away. It will work nicely allowing the script to start after the boot sequence, and thus ensuring the app remains running. 
