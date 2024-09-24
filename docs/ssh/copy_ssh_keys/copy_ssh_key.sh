#!/bin/bash

# Set path to the SSH key on the local machine
ssh_key_path=~/.ssh/dj_pr@zorab-surface.pub
server_list=~/.ssh/list_of_servers

for server in `cat $server_list`;
  do
    echo "Copying SSH key to $server..."
    ssh-copy-id -f -i $ssh_key_path $server
done


#!/bin/bash

# Set path to the SSH key on the local machine and list of servers file
ssh_key_path=~/.ssh/dj_pr@zorab-surface.pub
server_list=~/.ssh/list_of_servers

# Loop through list and ignore commneted out lines
for server in `grep -v '^#' list_of_servers`;
  do
    echo "Copying SSH key to $server..."
    ssh-copy-id -f -i $ssh_key_path $server
done