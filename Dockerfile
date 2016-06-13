# Dockerfile
FROM centos:centos6
RUN yum install -y epel-release
RUN yum install -y nodejs npm
RUN npm install -g coffee-script
COPY . itineraryCustomer
WORKDIR itineraryCustomer
ENTRYPOINT ["/bin/sh", "-c", "npm start"]
CMD ["--stack_size=131208"]