# Use the official Ubuntu 20.04 base image
FROM ubuntu:20.04
ENV DEBIAN_FRONTEND=noninteractive

# Update the package lists and upgrade installed packages
RUN apt update && apt upgrade -y

# Install net-tools
RUN apt install -y net-tools

# Install git
RUN apt install -y git

# Install Java 8
RUN apt install -y openjdk-8-jdk
RUN apt install -y openjdk-11-jdk
ENV JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64

# Install Open V Switch
RUN apt install -y openvswitch-switch

# Install wget
RUN apt install -y wget

# Install Python and Pip
RUN apt install -y python3.8
RUN apt install -y python3-pip

# Install RYU
RUN git clone https://github.com/faucetsdn/ryu.git
RUN cd ryu && pip install .

# Install OpenDaylight
RUN cd /tmp && wget https://nexus.opendaylight.org/content/repositories/opendaylight.release/org/opendaylight/integration/karaf/0.8.4/karaf-0.8.4.tar.gz
RUN cd /tmp && tar -zxvf karaf-0.8.4.tar.gz
RUN mv /tmp/karaf-0.8.4 /opt/karaf-0.8.4

# Install Maven 3.9.5
RUN cd /tmp && wget https://dlcdn.apache.org/maven/maven-3/3.9.5/binaries/apache-maven-3.9.5-bin.tar.gz
RUN cd /tmp && tar xvf apache-maven-3.9.5-bin.tar.gz -C /opt
ENV M2_HOME=/opt/apache-maven-3.9.5
ENV PATH ${M2_HOME}/bin:${PATH}

# Setup Maven for ODL
RUN mkdir ~/.m2
RUN wget -q -O - https://raw.githubusercontent.com/opendaylight/odlparent/master/settings.xml > ~/.m2/settings.xml

# Install bazel 3.7.2
ENV JAVA_HOME=/usr/lib/jvm/java-11-openjdk-amd64
RUN apt install apt-transport-https curl gnupg -y
RUN curl -fsSL https://bazel.build/bazel-release.pub.gpg | gpg --dearmor >bazel-archive-keyring.gpg
RUN mv bazel-archive-keyring.gpg /usr/share/keyrings
RUN echo "deb [arch=amd64 signed-by=/usr/share/keyrings/bazel-archive-keyring.gpg] https://storage.googleapis.com/bazel-apt stable jdk1.8" | tee /etc/apt/sources.list.d/bazel.list
RUN apt update && apt install bazel-3.7.2 -y
RUN ln -s /usr/bin/bazel-3.7.2 /usr/bin/bazel

# Install ONOS 2.7.0
RUN git clone https://gerrit.onosproject.org/onos
RUN cd onos && git checkout 2.7.0
RUN apt install python2 -y
RUN ln -s /usr/bin/python2 /usr/bin/python
RUN apt install zip -y
RUN cd onos && bazel build onos; exit 0
RUN cd onos && bazel build onos
ENV ONOS_ROOT /onos
ENV PATH /onos/tools/dev/bin:${PATH}
ENV PATH /onos/tools/test/bin:${PATH}
ENV PATH /onos/tools/package/runtime/bin:${PATH}

# Expose required ports
EXPOSE 6633
EXPOSE 6653
EXPOSE 1099
EXPOSE 8180
EXPOSE 8181

# Copy bash profile
COPY .bashrc /root/.bashrc

# Clone Sample Projects from Github
RUN cd /tmp && cd ..
RUN cd /tmp && wget https://raw.githubusercontent.com/shashankp28/SDN-Sample/main/settings.xml
RUN cd /tmp && cp settings.xml /root/.m2/settings.xml

# Clean up to reduce image size
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
