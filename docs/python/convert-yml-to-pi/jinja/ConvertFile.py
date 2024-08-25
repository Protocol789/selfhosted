from process_yaml_with_jinja import my_function

# Set the input file type
outputType = 1  # 0 = piholecname, 1 = piholedns file

if outputType == 0:
    input_filename = './pihole_cname_records_input_file.yaml'
    jinjatemplate = '05-pihole-custom-cname.conf.j2'
    templatetype = 'pihole_cname_records'
    print('CNAME chosen')
elif outputType == 1:
    input_filename = './input.yaml'
    jinjatemplate = 'custom.list.j2'
    templatetype = 'pihole_local_dns'
    print('DNS List chosen')

my_function(input_filename, jinjatemplate, templatetype)