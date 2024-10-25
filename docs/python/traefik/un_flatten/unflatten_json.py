from unflatten import unflatten
import json
import yaml
from flatten_json import flatten

def load_docker_conf(file):
     print(f'------------------load document-------------------------')
     # Convert to dict 
     document = file
     yamlfile = yaml.full_load(document)
     print(f'{yamlfile}')
     print(f'{type(yamlfile)}')

     print(f'{yamlfile["labels"][0]}')
     return yamlfile

def split_into_kv(file):
     print(f'------------------splity into kv pairs-------------------------')
     # Initialize an empty dictionary for the key-value pairs
     key_value_pairs = {}
     yamlfile = file

     # Iterate through the labels and split them into key-value pairs
     for label in yamlfile['labels']:
          key, value = label.split("=", 1)  # Split only on the first '='
          key_value_pairs[key] = value
          print(f'The key value pairs \n {key} {value}')

     # Print the resulting key-value pairs
     print(f'The key value pairs \n {key_value_pairs}')
     # print(f'type {type(key_value_pairs)}')
     # print(f'type {dir(key_value_pairs)}')
     # print(f'{list(key_value_pairs.items())[1]}')
     return key_value_pairs

def conv_json(file):
     print(f'-------------------convert to json------------------------')
     # Convert to json
     json_conv = json.dumps(file,indent= 2)
     print(f'{json_conv}')
     return json_conv

def conv_yaml(file):
     print(f'----------------output to yaml---------------------------')

     yaml_file_cnv = yaml.dump(file)
     print(f'YAML \n {yaml_file_cnv}')
     return yaml_file_cnv

def unflatten_doc(file):
     print(f'----------------unflatten---------------------------')

     # unflatten the json
     # flat_json = {"traefik.http.routers.sabnzbd.rule":"Host(`sabnzbd.zorab.im`)"}
     # unflat =  unflatten({"traefik.http.routers.sabnzbd.rule":"Host(`sabnzbd.zorab.im`)"})
     # print(f'flat json: \n {flat_json}')
     key_value_pairs = file
     json_values= key_value_pairs.items()

     unflat = unflatten(json_values)
     print(f'Unflattended json minified \n {unflat}')
     # print(f'{type(unflat)}')

     # output to json 
     # data = json.load(json_file)
     json1 = json.dumps(unflat,indent= 2)
     print(f'Pretty print json indent 2 {json1}')
     return unflat

def flatten_file(file, sep):

     print(f'----------------flatten file---------------------------')
     flatten_File = flatten(file, separator=sep)
     print(f'{flatten_File}')
     return flatten_File


if __name__ == "__main__":
    

     document = """
     labels:
          - "traefik.enable=true"
          - "traefik.http.routers.sabnzbd.rule=Host(`sabnzbd.zorab.im`)"
          - "traefik.http.routers.sabnzbd.entrypoints=websecure"
          - "traefik.http.routers.sabnzbd.tls.domains[0].main=zorab.im"
          - "traefik.http.routers.sabnzbd.tls.domains[0].sans=*.zorab.im"
          - "traefik.http.routers.sabnzbd.tls.certResolver=cloudflare"
          - "traefik.http.services.sabnzbd.loadbalancer.server.port=8082"
     """

     document2 = """
          - "traefik.enable":"true"
          - "traefik.http.routers.sabnzbd.rule":"Host(`sabnzbd.zorab.im`)"
          - "traefik.http.routers.sabnzbd.entrypoints":"websecure"
          - "traefik.http.routers.sabnzbd.tls.domains[0].main":"zorab.im"
          - "traefik.http.routers.sabnzbd.tls.domains[0].sans":"*.zorab.im"
          - "traefik.http.routers.sabnzbd.tls.certResolver":"cloudflare"
          - "traefik.http.services.sabnzbd.loadbalancer.server.port":"8082"
     """

     document3 = """
          - "traefik.enable"="true"
          - "traefik.http.routers.sabnzbd.rule"="Host(`sabnzbd.zorab.im`)"
          - "traefik.http.routers.sabnzbd.entrypoints"="websecure"
          - "traefik.http.routers.sabnzbd.tls.domains[0].main"="zorab.im"
          - "traefik.http.routers.sabnzbd.tls.domains[0].sans"="*.zorab.im"
          - "traefik.http.routers.sabnzbd.tls.certResolver"="cloudflare"
          - "traefik.http.services.sabnzbd.loadbalancer.server.port"="8082"
     """

     yaml_doc = """
---
http:
  routers:
    proxmox7:
      entryPoints:
        - websecure
      service: proxmox7-service
      rule: Host(`proxmox7.zorab.im`)
      tls:
        certResolver: cloudflare
  middlewares: null
  services:
    proxmox7-service:
      loadBalancer:
        passHostHeader: true
        serversTransport: "pve"
        servers:
          - url: https://192.168.68.177:8006
  serversTransports:
    pve:
      insecureSkipVerify: true
"""


if __name__ == "__main__":

     # Load yaml document
     print(f'Loading source yaml doc: \n {yaml_doc}')
     data = yaml.safe_load(yaml_doc)
     
     # Flattend document with / separator
     
     flat_file = flatten_file(data,'/')
     print(f'Convert to yaml')
     conv_yaml(flat_file)
     # print(f'{conv_yaml(flat_file)}')
     # print(f'{conv_yaml(flat_file)}')
     
     print(f'---------------- iterate through array--------------------------')
     print(f'Printing out each key value pair')
     for get in flat_file.items():
          key = get[0]
          value = get[1]
          print(f'Key: {key} - Value: {value}')
          # print(value)
          # get_kv(key,value)

     if 1 == 2:
          yamlfile = load_docker_conf(document)
          kvpairs = split_into_kv(yamlfile)

          print(f'Flat JSON')
          conv_json(kvpairs)
          print('Unflattened kv pairs')
          unflat_doc = unflatten_doc(kvpairs)
          
          print('flat yaml')
          conv_yaml(kvpairs)
          print('UN flat yaml')
          conv_yaml(unflat_doc)

          file1 = {'traefik.enable': 'true', 'traefik.http.routers.sabnzbd.rule': 'Host(`sabnzbd.zorab.im`)', 'traefik.http.routers.sabnzbd.entrypoints': 'websecure', 'traefik.http.routers.sabnzbd.tls.domains[0].main': 'zorab.im', 'traefik.http.routers.sabnzbd.tls.domains[0].sans': '*.zorab.im', 'traefik.http.routers.sabnzbd.tls.certResolver': 'cloudflare', 'traefik.http.services.sabnzbd.loadbalancer.server.port': '8082'}

          print(f'Reflatten the file')
          flatten_file(unflat_doc)
          conv_json(unflat_doc)
          
          conv_yaml(unflat_doc)