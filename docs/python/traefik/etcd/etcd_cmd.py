import etcd3

# etcd server connection string
etcd_host = '192.168.68.211'
etcd_port = 2379

# Connect to the etcd server
print(f"Create etcd client @ '{etcd_host}' on port '{etcd_port}'")
# etcd = etcd3.client(host='dockerhost01.server', port=2379)
etcd = etcd3.client(host=etcd_host, port=etcd_port)

def put_kv(key,value):

    print(f"Putting a new key-value pair ('{key}', '{value}')...")
    etcd.put(key, value)
    print(f"Key '{key}' has been set to '{value}'.")

def get_kv(key,value):
    
    # Get the value for the key to confirm it was set
    print(f"Now getting value from ('{key}', '{value}')...")
    
    bar_value = etcd.get(key)
    # print(bar_value)

     # Convert the byte string to a string using the decode() method
    if bar_value[0] is not None:
        print(f"Current value for '{key}': '{bar_value[0].decode('utf-8')}'")
        ret_value = bar_value[0].decode("utf-8")
        if ret_value != value:
            print(f'problem')
        elif ret_value == value:
            print(f'All is good')
    if bar_value[0] is None:
        print(f'Value is NONE!')

def del_kv(key,value):

    
    # Delete the key
    print(f"Deleting the key '{key}'...")
    etcd.delete(key)
    
    print(f"Key '{key}' has been deleted.")

    key = '222'
    # Confirm deletion
    deleted_bar_value = etcd.get(key)
    if deleted_bar_value[0] is None:
        print(f"Confirmed: Key '{key}' does not exist after deletion.")
    else:
        print(f"Key '{key}' still exists with value: {deleted_bar_value[0].decode('utf-8')}")

def del_kv_prefix(prefix):
    etcd.delete_prefix(prefix)

def get_all_keys():
    all = etcd.get_all_response()
    print(f'There are {all.count} keys in KV ')
    # print(all[2].key)
    # print(all.kvs)

    print(f'Here are the keys: \n ----------------')
    for kvs in all.kvs:
        print (f'Key: {(kvs.key).decode("utf-8")}') 
    print(f'----------------')
    print(f'Here are the values: \n ----------------')
    for kvs in all.kvs:
        print (f'Value: {(kvs.value).decode("utf-8")}') 
    print(f'----------------')

if __name__ == "__main__":
    
    # Print out all keys and value
    get_all_keys()

    # Delete key by prefix
    # del_kv_prefix('traefik')

    # key = 'traefik.http.services.sabnzbd.loadbalancer.server.port'
    # value = '8082'
    key = 'traefik/http/routers/sabnzbd/service'
    value = 'sabnzbd-service'
    # key = 'traefik/http/routers/sabnzbd/service'
    # value = 'sabnzbd'
    # key = 'traefik/http/services/sabnzbd/loadBalancer/servers/0/url'
    # value = 'https://sabnzb.zorab.im'
    key = 'traefik/http/routers/sabnzbd/service'
    value = 'sabnzbd-service'
    key = 'traefik/http/services/sabnzbd-service/loadBalancer/servers/0/url'
    value = 'https://sabnzb.zorab.im'

    # Creating a Python dictionary with the given keys and values
    traefik_dict = {
        'traefik/http/routers/sabnzbd/service': 'sabnzbd-service',
        'traefik/http/services/sabnzbd-service/loadBalancer/servers/0/url': 'https://sabnzb.zorab.im'
    }

    # Displaying the created dictionary
    print(list(traefik_dict.items())[0][0])

    # ('traefik.http.services.sabnzbd.loadbalancer.server.port', '8082')
    # # Upload a key value pair 
    # put_kv(key, value)
    # # Check if value matches
    get_kv(key,value)

    # del_kv(key,value)

