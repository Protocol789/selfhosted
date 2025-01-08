import etcd3

# etcd server connection string
etcd_host = 'dockerhost01.server'
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
    bar_value = etcd.get(key)
     # Convert the byte string to a string using the decode() method
    print(f"Current value for '{key}': '{bar_value[0].decode('utf-8')}'")
    ret_value = bar_value[0].decode("utf-8")

    if ret_value != value:
        print(f'problem')
    else:
        print(f'Value matches input! ')

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

if __name__ == "__main__":
    
    
    key = 'http.routers.sabnzb.rule'
    value = 'Host(`sabnzbd.zorab.im`)'

    # Upload a key value pair 
    put_kv(key, value)
    # Check if value matches
    get_kv(key,value)

    del_kv(key,value)