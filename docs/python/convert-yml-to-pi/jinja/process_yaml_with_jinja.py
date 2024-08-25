from jinja2 import Environment, FileSystemLoader
import yaml

def my_function(inputf, templatef, templatetype):

    # Input files
    input_filename = inputf
    output_filename = f'./{templatetype}_output_file'
    jinjatemplate = templatef 
    # input_filename = './input.yaml'
    # output_filename = './outputfile'
    # jinjatemplate = 'custom.list.j2'

    print(f'Processing with: {templatetype}')
    print(f'Processing with: {jinjatemplate}')

    with open(input_filename, 'r') as stream:
        data_loaded = yaml.safe_load(stream)
    
    # print(data_loaded)

    # Load up the templates folder containing the Jinja template
    env = Environment(loader=FileSystemLoader('templates'), trim_blocks=True, lstrip_blocks=True)

    # Get the template
    template = env.get_template(jinjatemplate)

    # Render the template with the entire data
    
    if templatetype == 'pihole_cname_records':
        yaml_content = template.render( pihole_cname_records = data_loaded[ f'{templatetype}'] )
    elif templatetype == 'pihole_local_dns':
        yaml_content = template.render( pihole_local_dns = data_loaded[ f'{templatetype}'] )

    # Print the rendered content
    print(yaml_content)

    # Write the output to a file
    with open(output_filename, 'w') as yaml_file:
        yaml_file.write(yaml_content)

    print(f"Pi hole file output written to {output_filename}")