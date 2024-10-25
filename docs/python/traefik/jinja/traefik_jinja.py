from jinja2 import Template
from unflatten import unflatten
import json
import yaml
from flatten_json import flatten


def traefik_conf(template_string,service_value, base_domain, service_port, service_url):
    # Create a Jinja2 Template object
    template = Template(template_string)

    # Define the values to be replaced
    # service_value = 'sabnzbd'  # You can change this to any other service name
    # base_domain = 'zorab.im'
    # service_port = '8082'

    # Render the template with the desired values
    rendered_output = template.render(service_name=service_value, base_domain = base_domain, service_port = service_port, service_url = service_url)

    # Print the rendered JSON
    print(f'The rendered object \n {rendered_output}')
    return rendered_output

def flatten_file(string):

    # Flatten the json config into dot notation
    flatten_File = flatten(json.loads(string), separator='.')
    print(f'The flattened file {flatten_File}')
    return flatten_File


def create_get(flatfile):
    for get in flatfile.items():
        
        # print(f'Type: {type(get)}')
        # print(f'Dir: {dir(get)}')
        # print(f'full value: {get}')#
        # print(f'Index 0: {get[0]}')
        # print(f'Index 1: {get[1]}')
    
        key = get[0]
        value = get[1]
        print(f"Putting a new key-value pair ('{key}', '{value}')...")

if __name__ == "__main__":
  template_string = """
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

  # Convert via jinja template 
  service_value = 'sabnzbd'  # You can change this to any other service name
  base_domain = 'zorab.im'
  service_port = '8082'
  json_output = traefik_conf(template_string,service_value, base_domain, service_port)


  # Flatten the file 
  flatfile = flatten_file(json_output)

  # Create get
  create_get(flatfile)

