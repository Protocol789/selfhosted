from jinja.traefik_jinja import * 
from etcd.etcd_cmd import * 
from un_flatten.unflatten_json import *
from flatten_json import flatten

template_json = """
{
    "traefik": {
      "enable": "true",
      "http": {
        "routers": {
          "{{ service_name }}": {
            "rule": "Host(`{{ service_name }}.{{ base_domain }}`)",
            "entrypoints": "websecure",
            "tls": {
              "domains": [
                {
                  "main": "{{ base_domain }}",
                  "sans": "*.{{ base_domain }}"
                }
              ],
              "certResolver": "cloudflare"
            }
          }
        },
        "services": {
          "{{ service_name }}": {
            "loadbalancer": {
              "server": {
                "port": "{{ service_port }}"
              }
            }
          }
        }
      }
    }
  }
"""
template_yaml = """
traefik.http.routers.{{ service_name }}.entryPoints: websecure
traefik.http.routers.{{ service_name }}.service: {{ service_name }}
traefik.http.routers.{{ service_name }}.rule: Host(`{{ service_name }}.{{ base_domain }}`)
traefik.http.routers.{{ service_name }}.tls.certResolver: cloudflare
traefik.http.routers.{{ service_name }}.tls.domains.0.main: {{ base_domain }}
traefik.http.routers.{{ service_name }}.tls.domains.0.sans: '*.{{ base_domain }}'
traefik.http.services.{{ service_name }}.loadBalancer.servers.0.url: '{{ service_url }}'
"""

def loop_keys(file):
  print('hello')

if __name__ == "__main__":

  source = template_yaml
  # source = template_json

  if source == template_yaml: 

    service_value = 'riven'  # You can change this to any other service name
    base_domain = 'zorab.im'
    service_port = '8082'
    service_url = 'http://frontend.server:3000'

    # Yaml file jinja
    jinja2_yml = traefik_conf(template_yaml,service_value, base_domain, service_port, service_url)
    
    # Load up yaml file into dict
    jinj2_cnv = yaml.safe_load(jinja2_yml)

    # Replace . with / for flattened file
    # jinj2_cnv.replace(".","/")
    for get in jinj2_cnv.items():
      key = str(get[0]).replace(".","/")
      value = str(get[1])
      print(key)
      print(value)
      put_kv(key,value)
      get_kv(key,value)    

    # Unflatten file
    # unflat_doc = unflatten_doc(jinj2_cnv)

    # flat_file = flatten_file(jinj2_cnv)
    # jinj2_cnv.replace(".","/")
    # flatten_File = flatten(jinj2_cnv,".")
    # print(conv_yaml(flatten_File))

    # for get in jinj2_cnv.items():
    #   key = str(get[0]).replace(".","/")
    #   value = str(get[1])
    #   print(key)
    #   print(value)
    #   put_kv(key,value)
    #   get_kv(key,value)


  if source == template_json:  
    # Do the Jinja output
    service_value = 'sabnzbd'  # You can change this to any other service name
    base_domain = 'zorab.im'
    service_port = '8082'
    service_url = 'https://192.168.68.177:8006'

    # Json file jinja
    jinja2_json = traefik_conf(template_json,service_value, base_domain, service_port,service_url)
    jinj2_cnv = json.loads(jinja2_json)
    
    # flatten the file
    flat_file = flatten_file(jinj2_cnv,'/')

    ## Do the crreation of KV's

    for get in flat_file.items():
        key = get[0]
        value = get[1]
        # put_kv(key,value)
        get_kv(key,value)

    # conv_yaml(flat_file)



