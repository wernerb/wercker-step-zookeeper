wercker-step-zookeeper
======================

Downloads, installs and runs Zookeeper for usage in wercker boxes.

Example
--------

By default installs ZooKeeper 3.4.5.
```
    - wernerb/zookeeper
```


This can be overriden by supplying the tarball url.
Add $ZOOKEEPER_TARBALL as deploy target or application environment variable.

```
    - wernerb/zookeeper:
        zookeeper-tarball: $ZOOKEEPER_TARBALL
```

