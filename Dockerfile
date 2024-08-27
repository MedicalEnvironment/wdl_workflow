# Start with the Ubuntu base image and install Java manually
FROM ubuntu:20.04

# Install dependencies, including Java
RUN apt-get update && apt-get install -y \
    wget \
    unzip \
    python3 \
    openjdk-21-jdk \
    && rm -rf /var/lib/apt/lists/*

# Set the working directory
WORKDIR /app

# Download and install Cromwell
RUN wget https://github.com/broadinstitute/cromwell/releases/download/87/cromwell-87.jar -O cromwell-87.jar && chmod +r /app/cromwell-87.jar

# Copy your workflow and config files into the image
COPY cromwell-fixed.conf /app/cromwell-fixed.conf
COPY wdl1.1.wdl /app/wdl1.1.wdl
COPY fastqc_workflow_inputs.json /app/fastqc_workflow_inputs.json

# Set the entrypoint to run Cromwell
ENTRYPOINT ["java", "-Dconfig.file=/app/cromwell-fixed.conf", "-jar", "/app/cromwell-87.jar"]
CMD ["run", "/app/wdl1.1.wdl", "--inputs", "/app/fastqc_workflow_inputs.json"]


