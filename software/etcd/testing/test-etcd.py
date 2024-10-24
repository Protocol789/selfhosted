import etcd3

# Connect to the etcd server
etcd_host = 'dockerhost01.server'
etcd_port = 2379

print(f"Attempting to create etcd client @ '{etcd_host}' on port '{etcd_port}'")
# etcd = etcd3.client(host='dockerhost01.server', port=2379)
etcd = etcd3.client(host=etcd_host, port=etcd_port)

# Get the value for the key 'foo'
print("Attempting to get the value for the key 'foo'...")
getfoo = etcd.get('foo')

if getfoo[0] is not None:
    print(f"Retrieved value for 'foo': {getfoo[0].decode('utf-8')}")
else:
    print("Key 'foo' does not exist.")

# Put a new key-value pair ('bar', 'doot')
print("Putting a new key-value pair ('bar', 'doot')...")
etcd.put('bar', 'doot')
print("Key 'bar' has been set to 'doot'.")

# Get the value for the key 'bar' to confirm it was set
bar_value = etcd.get('bar')
print(f"Current value for 'bar': {bar_value[0].decode('utf-8')}")

# Delete the key 'bar'
print("Deleting the key 'bar'...")
etcd.delete('bar')
print("Key 'bar' has been deleted.")

# Confirm deletion
deleted_bar_value = etcd.get('bar')
if deleted_bar_value[0] is None:
    print("Confirmed: Key 'bar' does not exist after deletion.")
else:
    print(f"Key 'bar' still exists with value: {deleted_bar_value[0].decode('utf-8')}")