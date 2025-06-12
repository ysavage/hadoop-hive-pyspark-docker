# Use the official Jupyter PySpark Notebook image as the base image
FROM jupyter/pyspark-notebook:latest

USER root

# Install Hive and Hadoop client tools
RUN apt-get update && \
    apt-get install -y wget gnupg lsb-release openjdk-8-jdk && \
    wget https://archive.apache.org/dist/hive/hive-2.3.9/apache-hive-2.3.9-bin.tar.gz && \
    tar -xzf apache-hive-2.3.9-bin.tar.gz -C /opt/ && \
    mv /opt/apache-hive-2.3.9-bin /opt/hive && \
    rm apache-hive-2.3.9-bin.tar.gz && \
    echo "export HIVE_HOME=/opt/hive" >> /etc/profile && \
    echo "export PATH=$PATH:$HIVE_HOME/bin" >> /etc/profile

# Set environment variables
ENV HIVE_HOME=/opt/hive
ENV PATH=$PATH:$HIVE_HOME/bin
ENV JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64
# Set environment variables for PySpark
ENV JUPYTER_TOKEN: ""
ENV JUPYTER_PASSWORD: ""
ENV JUPYTER_PORT: 8888
ENV SPARK_UI_PORT: 4040
ENV GRANT_SUDO: yes

ENV PYSPARK_PYTHON=python3
ENV PYSPARK_DRIVER_PYTHON=jupyter
ENV PYSPARK_DRIVER_PYTHON_OPTS="lab --ip=0.0.0.0 --port=8888 --allow-root --no-browser --NotebookApp.token='' --NotebookApp.password=''"

# Create Hive warehouse directory
RUN mkdir -p /user/hive/warehouse && chmod -R 777 /user/hive/warehouse

# Switch back to jovyan user
USER $NB_UID

# Set working directory
WORKDIR /home/jovyan/work

# Launch JupyterLab with no token/password / included above
# CMD ["jupyter", "lab", "--ip=0.0.0.0", "--port=8888", "--allow-root", "--no-browser", "--NotebookApp.token=''", "--NotebookApp.password=''"]