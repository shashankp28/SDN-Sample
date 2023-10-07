# Open Daylight Controller

### Deafult Installation

1. The default installation is in the following directory:

```
/opt/karaf-0.8.4
```

2. The OpenDaylight CLI can be used, bu the following command:

```
opendl
```

3. The GUI Can be installed by using feature install command in ODL CLI:

```
feature:install odl-restconf odl-l2switch-switch odl-mdsal-apidocs odl-mdsal-clustering
feature:install odl-dlux-core odl-dluxapps-nodes odl-dluxapps-topology odl-dluxapps-yangui
feature:install odl-dluxapps-yangvisualizer odl-dluxapps-yangman
```

4. The GUI can be accessed by using the following URL:

```
http://<ip-address>:8181/index.html
```

5. The username and password for the GUI is:

```
Username: admin
Password: admin
```

### Sample hello project

1. The example `hello` project in this folder can be built using the following command:

```
cd /home/ODL-Projects/hello
mvn clean install -DskipTests -Dcheckstyle.skip
```

2. Run the project using the following command:

```
./karaf/target/assembly/bin/karaf
```

3. Wait for sometime and open the GUI to make the Hello RPC

```
http://<ip-address>:8181/apidoc/explorer/index.html#!/hello(2021-03-21)
```

**Note:** The login credentials are the same as mentioned above.

4. Try out the example using the following input:

```
{
  "hello:input": {
        "hello:name": "MyName"
   }
}
```

5. The output should be:

```
{
  "output": {
    "greeting": "Hello MyName"
  }
}
```

### Custom Application

1. A custom project can be created using variations of the following command:

```
mvn archetype:generate -DarchetypeGroupId=org.opendaylight.controller -DarchetypeArtifactId=opendaylight-startup-archetype \
-DarchetypeRepository=http://nexus.opendaylight.org/content/repositories/opendaylight.release \
-DarchetypeVersion=1.0.0-Lithium
```

2. More information can be found at the following link [Oxygen Dev Docs](https://docs.opendaylight.org/en/stable-oxygen/developer-guide/developing-apps-on-the-opendaylight-controller.html)