|Commands|Purpose|
|----|----|
|journalctl -r|Use the -r option to display the newest log entries first|
|journalctl -n 3|Use the –n [number] option to display a specific number of the most recent log entries|
|journalctl -p crit|Use the –p [priority] option to display only log entries of a specific [priority]. Valid priorities are debug, info, notice, warning, err, crit, alert, and emerg|
|journalctl -u ntpd|Use the –u [systemd_unit] option to display only log entries for the specified systemd unit|
|journalctl -o verbose|Use the –o [output_form] option to format the output. Valid output formats are short, short-iso, short-precise, short-monotonic, verbose, export, json, json-pretty, json-see, and cat|