"""
File: convert-pifile-yml.py
Author: Daniel Zorab
Date: 28/07/24
Description: Takes a pihole dns file and converts to yaml
"""

import yaml
import os

# Change directory to the path of the script
os.chdir(os.path.dirname(os.path.abspath(__file__))) 

# Print current working directory
# print(os.getcwd())

# Define the input and output filenames
input_filename = 'source.txt'
output_filename = 'output.yaml'

# Initialize the list to hold the parsed records
pihole_local_dns = []

# Read the source data from the file
with open(input_filename, 'r') as file:
    for line in file:
        line = line.strip()  # Remove leading/trailing whitespace
        if line:  # Check if the line is not empty
            ip, domain = line.split()
            pihole_local_dns.append({'ip': ip, 'domain': domain})

# Create the final structure
output_data = {
    'pihole_local_dns': pihole_local_dns
}

# Convert to YAML format
yaml_output = yaml.dump(output_data, sort_keys=False)

# Print the YAML output
print(yaml_output)

# Write the YAML output to a file
with open(output_filename, 'w') as yaml_file:
    yaml_file.write(yaml_output)

print(f"YAML output written to {output_filename}")