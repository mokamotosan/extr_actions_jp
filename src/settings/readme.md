# setting path etc

1. add below line to .bashrc
```
$ export PYTHONPATH= '/mnt/c/Users/mokam/myProjects/pk_verb_impression/current/src/_settings/'
```

2. type:
```
(home)$ source ~/.bashrc
```

3. check:
```
$ python
>>> import sys, pprint
>>> pprint.pprint(sys.path)
```