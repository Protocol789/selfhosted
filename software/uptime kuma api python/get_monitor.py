from uptime_kuma_api import UptimeKumaApi, MonitorType
import yaml
import json

# Set the monitor ID
monitorid = 3

# Set the outputype
outputType = 0  # 0 = json, 1 = yaml
outputPrint = 1  # 1 = true, 0 =false
outputToFile = 0  # # 1 = true, 0 =false

# Login to Uptime Kuma API
api = UptimeKumaApi("https://uptimekuma.zorab.im")
api.login("daniel", "logMEin777")

# Get monitor from API
result = api.add_monitor( type=MonitorType.DOCKER, name="Google", docker_host=1, docker_container="sonarr")

# Convert to YAML format
yaml_output = yaml.dump(result, sort_keys=False)

# Convert to JSON format
json_output = json.dumps(result)

if outputPrint == 1:
    # Print the outputs in various forms
    if outputType == 0:
        print(json_output)
    elif outputType == 1:
        print(yaml_output)

# print(result)

if outputType == 0 and outputToFile == 1:  # json
    # Write the JSON output to a file
    with open("./monitors_result.json", "w") as outfile:
        outfile.write(json_output)
    print("JSON output written to ./monitors_result.json")

elif outputType == 1 and outputToFile == 1:  # YAML
    # Write the YAML output to a file
    with open("./monitors_result.yaml", "w") as yaml_file:
        yaml_file.write(yaml_output)
    print("YAML output written to ./monitors_result.yaml")

# Disconnect from API
api.disconnect()
