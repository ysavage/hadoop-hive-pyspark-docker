FROM jupyter/pyspark-notebook:spark-3.3.0

USER root

# Install Hive and Hadoop client tools
RUN apt-get update && \
    apt-get install -y wget gnupg lsb-release openjdk-8-jdk && \
    wget https://downloads.apache.org/hive/hive-2.3.9/apache-hive-2.3.9-bin.tar.gz && \
    tar -xzf apache-hive-2.3.9-bin.tar.gz -C /opt/ && \
    mv /opt/apache-hive-2.3.9-bin /opt/hive && \
    rm apache-hive-2.3.9-bin.tar.gz && \
    echo "export HIVE_HOME=/opt/hive" >> /etc/profile && \
    echo "export PATH=$PATH:$HIVE_HOME/bin" >> /etc/profile

# Set environment variables
ENV HIVE_HOME=/opt/hive
ENV PATH=$PATH:$HIVE_HOME/bin
ENV JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64

# Create Hive warehouse directory
RUN mkdir -p /user/hive/warehouse && chmod -R 777 /user/hive/warehouse

# Switch back to jovyan user
USER $NB_UID

# Set working directory
WORKDIR /home/jovyan/work