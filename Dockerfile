FROM fedora

# Setup for run mongoclient
EXPOSE 3000
WORKDIR /opt/mongoclient
CMD ["/usr/local/bin/meteor", "run", "--port", "3000"]

# Install required softwares
RUN dnf install -y tar procps-ng && dnf clean all

# Install MeteorJS
RUN curl https://install.meteor.com/ | sh

# Append mongoclient source
WORKDIR /tmp/mongoclient
ADD / /tmp/mongoclient
RUN cp -R /tmp/mongoclient /opt/mongoclient
WORKDIR /opt/mongoclient
RUN rm -rf .meteor/local

# pre-update some libraries
RUN /usr/local/bin/meteor update
