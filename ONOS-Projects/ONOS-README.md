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

3. To access CLI of onos run two commands in separate terminals

```
Terminal 1: bazel run onos-local clean debug
Terminal 2: onos localhost
```

4. The relevant Apps can be installed using the following commands:

```
app activate org.onosproject.openflow
app activate org.onosproject.fwd
```

4. Or they can be installed using the GUI.

## Creating a new project

1. To create a new project, run the following command:

```
onos-create-app app org.foo foo-app 1.0-SNAPSHOT org.foo.app
```

2. Build the application

```
cd foo-app
mvn clean install
```

3. The target `oar` file will be created in the `target` directory which can be added to ONOS using the GUI or the CLI.
