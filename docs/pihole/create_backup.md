# Summary

Create a backup teleport file via command line for Pihole 

## Script

`sudo pihole -a -t`

Output 

A file in wherever you ran it similar to this:  
`pi-hole-pihole-1-teleporter_2024-08-26_11-08-09.tar.gz`

Copy file to backup location
`scp *.tar.gz daniel@backend.server:/backup/data/pihole02`

Remove local backup file
`rm *.tar.gz -f`

## Links

- [Pihole][def] teleport web documentation

[def]: https://docs.pi-hole.net/core/pihole-command/#teleport
