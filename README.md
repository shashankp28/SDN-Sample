# SDN Development Environment

The SDN development environment has the following specifications

```
OS: Ubuntu 20.04

<------------- RYU ------------->
python3: Python 3.8.10
ryu-manager: Version 4.34
pip: pip 20.0.2 from (python 3.8)

<------------- OpenDaylight ------------->
java: openjdk version 8
mvn (Maven): Apache Maven 3.9.5
Default OpenDaylight: Version Oxygen (0.8.4)

<------------- ONOS ------------->
java: openjdk version 11
mvn (Maven): Apache Maven 3.9.5
bazel: Version 3.7.2
Default ONOS: Version 2.7.0
```

## Installation

1. Install Docker Engine from the official website:

```
curl -fsSL https://get.docker.com -o get-docker.sh
sudo sh get-docker.sh
sudo usermod -aG docker $USER
newgrp docker
```

**Note:** Make sure that you are able to add Docker to sudo group. So as to run Docker commands without sudo.

2. Open VSCode and install the `Docker` Extension for VSCode, this will help you to manage the Docker containers from VSCode.

3. Run the following command to pull and run Docker image for SDN development environment

```
docker run -d -it --restart always --name SDN -v $(pwd)/home:/home shashankp2832/sdn:latest
```

4. Once the container is Run, you should be able to see it in the `Containers` Tab of the Docker Extension for VSCode.

```
Container Name: sdn:latest
```

5. Right click on the container and click on `Attach Visual Studio Code` to open a new VSCode window for the container.

6. Here you can open the `/home` folder of the container in VSCode which contains sample projects and documentation for `RYU`, `ODL` and `ONOS`

## IMPORTANT NOTE:

1. Since newer versions of `ODL` do not support dlux (GUI), before starting a project in **_ODL_** make sure to change **JAVA_HOME** path to `jdk-8`:

```
export JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64
```

2. ONOS requires `bazel` to build the project, which runs on JDK-11. So before starting a project in **_ONOS_** make sure to change **JAVA_HOME** path to `jdk-11`:

```
export JAVA_HOME=/usr/lib/jvm/java-11-openjdk-amd64
```
