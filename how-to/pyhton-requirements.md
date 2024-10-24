# Summary

Save *FULL* requirements.txt for portability and use with python

## TL;DR

```
pip3 install pipreqs
pip3 install pip-tools
```

Use the following to build a deterministic requirements.txt

`pipreqs --savepath=requirements.in && pip-compile`

### Links 

Scraped from this post [here][def]

[def]: https://stackoverflow.com/questions/31684375/automatically-create-file-requirements-txt