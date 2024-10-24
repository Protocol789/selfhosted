# Summary

Tests the connection to the etcd service

## Preruistates 

- Python 3

## Steps

1. Create a a virtual environment
`python3 -m venv venv`

2. Activate it
`source venv/bin/activate` 

3. Install requirements for pyhton library
`pip3 install -r requirements.txt`

3. Configure the host + port in the testing python file [here](test-etcd.py)

4. Run the python testing file 

## Example output

```text
Attempting to create etcd client @ 'dockerhost01.server' on port '2379'
Attempting to get the value for the key 'foo'...
Retrieved value for 'foo': bar
Putting a new key-value pair ('bar', 'doot')...
Key 'bar' has been set to 'doot'.
Current value for 'bar': doot
Deleting the key 'bar'...
Key 'bar' has been deleted.
Confirmed: Key 'bar' does not exist after deletion.
```
