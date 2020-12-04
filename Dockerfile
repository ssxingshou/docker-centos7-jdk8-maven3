FROM registry-vpc.cn-shenzhen.aliyuncs.com/ssxs-docker/ssxs-repo/ssxs-centos7-jdk8:1

MAINTAINER Base Image Maven3 <haixiang.dai@ssxingshou.com>

ARG MAVEN_VERSION=3.6.1
ARG MAVEN_HOME=/data/opt/maven
ARG MAVEN_HOME_REF=${MAVEN_HOME}/ref
ARG USER_HOME_DIR="/root"
ARG BASE_URL=http://mirrors.tuna.tsinghua.edu.cn/apache/maven/maven-3/${MAVEN_VERSION}/binaries

RUN mkdir -p ${MAVEN_HOME} ${MAVEN_HOME_REF} \
  && curl -o /tmp/apache-maven.tar.gz ${BASE_URL}/apache-maven-${MAVEN_VERSION}-bin.tar.gz \
  && tar -xzf /tmp/apache-maven.tar.gz -C ${MAVEN_HOME} --strip-components=1 \
  && rm -f /tmp/apache-maven.tar.gz \
  && ln -s ${MAVEN_HOME}/bin/mvn /usr/bin/mvn

COPY mvn-entrypoint.sh /usr/local/bin/mvn-entrypoint.sh
COPY settings-docker.xml $USER_HOME_DIR/.m2/settings.xml

ENV MAVEN_HOME ${MAVEN_HOME}
ENV MAVEN_CONFIG "$USER_HOME_DIR/.m2"

ENTRYPOINT ["/usr/local/bin/mvn-entrypoint.sh"]
