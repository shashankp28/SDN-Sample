# ONOS Development Environment

1. To run ONOS with bazel

```
cd /onos
bazel run onos-local
```

2. The GUI can be accessed at:

```
http://<ip>:8181/onos/ui/login.html

Username: onos
Password: rocks
```

3. The command line interface (CLI) can be accessed at:

```
bazel run onos-local clean debug
```

4. The relevant Apps can be installed using the following commands:

```
app activate org.onosproject.openflow
app activate org.onosproject.fwd
```

4. Or they can be installed using the GUI.
