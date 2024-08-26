# Docker Installation Guide

Before getting started to work with the WDL workflow please make sure you get yourself familiar with Docker and Docker Hub

## Windows

To install Docker Desktop on Windows, follow the instructions provided in the official Docker documentation:
- [Install Docker Desktop on Windows | Docker Docs](https://docs.docker.com/desktop/install/windows-install/)

For a visual guide, you can also refer to the following YouTube tutorial:
- [How To Install Docker on Windows? A Step-by-Step Guide (youtube.com)](https://www.youtube.com/watch?v=XXXXX)

## Mac

To install Docker Desktop on Mac, follow the instructions provided in the official Docker documentation:
- [Install Docker Desktop on Mac | Docker Docs](https://docs.docker.com/desktop/install/mac-install/)

For additional help, you can view this YouTube video:
- [How To Install Docker on Mac / MacOS (2024) (youtube.com)](https://www.youtube.com/watch?v=XXXXX)

## Linux

To install Docker Desktop on Linux, follow the instructions provided in the official Docker documentation:
- [Install Docker Desktop on Linux | Docker Docs](https://docs.docker.com/desktop/install/linux-install/)

For a detailed guide specific to Ubuntu, check out this YouTube tutorial:
- [Docker Installation In Ubuntu | How To Install Docker In Ubuntu? | Docker Installation | Simplilearn (youtube.com)](https://www.youtube.com/watch?v=cqbh-RneBlk)

Guides: https://docs.docker.com/guides/
Manuals: https://docs.docker.com/manuals/

## Building a Docker Image for FASTQC

This guide details the steps to build a Docker image containing the FASTQC tool.

**Prerequisites:**

* Docker installed on your local machine.

**Steps:**

1. **Create a Dockerfile:**

   * Start by creating a new file named `Dockerfile` (no extension) in a new directory.
   * Open the `Dockerfile` using your preferred text editor (e.g., `vim`, `nano`).

2. **Choose a base image:**

   * In the `Dockerfile`, specify a base image to build upon. This example uses the official Ubuntu image:

     ```dockerfile
     FROM ubuntu:latest
     ```

3. **Install dependencies:**

   * Install any required dependencies for FASTQC. Here, we need `openjdk-11-jre-headless` for Java and `unzip` to extract the downloaded tool.

     ```dockerfile
     RUN apt-get update && apt-get install -y openjdk-11-jre-headless unzip
     ```

4. **Download FASTQC:**

   * Download the FASTQC tool from the official source within the Docker image using `wget`:

     ```dockerfile
     RUN wget https://www.bioinformatics.babraham.ac.uk/projects/fastqc/fastqc_v0.11.9.zip && unzip fastqc_v0.11.9.zip
     ```

5. **Set permissions:**

   * Grant execute permissions for the FASTQC script:

     ```dockerfile
     RUN chmod +x /FastQC/fastqc
     ```

6. **Set the entry point:**

   * Define the entry point for the Docker image, specifying the command to run when the container starts.  Here, set it to the FASTQC tool:

     ```dockerfile
     ENTRYPOINT ["/FastQC/fastqc"]
     ```

7. **Build the Docker image:**

   * Save the `Dockerfile`.
   * Navigate to the directory containing the `Dockerfile` in your terminal.
   * Build the image using the following command:

     ```bash
     docker build -t fastqc-image .
     ```

     * Replace `fastqc-image` with a desired name for your image.

8. **Verify the image:**

   * Check if the image was built successfully by running:

     ```bash
     docker images
     ```

     * You should see an entry listing your image name, tag (usually `latest`), image ID, creation time, and size.

9. **Save the image (optional):**

   * To save the image as a compressed archive file for future use, run:

     ```bash
     docker save e476358bd157 | gzip > fastqc_v0.11.9_image.tar.gz
     ```

     * Replace `e476358bd157` with the actual image ID obtained from step 8.

10. **(Optional) Push the image to Docker Hub:**

   * Create a Docker Hub account ([https://hub.docker.com/](https://hub.docker.com/)) if you want to share the image publicly.
   * Tag the image with your desired username and repository name:

     ```bash
     docker tag fastqc-image <your_username>/<repository_name>:fastqc_v0.11.9
     ```

     * Replace `<your_username>` and `<repository_name>` with your actual details.

   * Push the tagged image to Docker Hub:

     ```bash
     docker push <your_username>/<repository_name>:fastqc_v0.11.9
     ```

**Additional Notes:**

* You can use this Docker image to run FASTQC commands within a containerized environment.
* The provided version of FASTQC (v0.11.9) can be updated by modifying the download URL in the `Dockerfile`.
* Refer to the official FASTQC documentation for detailed usage instructions: [invalid URL removed] 

## Accessing Documents and Materials

To access documents and other useful materials from the server, follow these steps:

1. **Open Your Terminal**

2. **Change Directory to Access Files**
   Enter the following command to navigate to the directory containing the documents:
   ```bash
   cd /home/groups/rsu/your_username/
Copy Files to Your Local Machine.

Use the scp command (secure copy) to transfer files from the server to your local machine. 

## Copying Files from a Remote Server with scp

This guide explains how to use the `scp` command to securely copy files from a remote server to your local machine.

**Instructions:**

1. **Replace placeholders:** 
    * `username`: Replace this with your actual username on the remote server.
    * `server_address`: Replace this with the IP address or hostname of the remote server.
    * `/path/to/local/directory/`: This is the directory on your local machine where you want to store the copied files.

2. **Run the command:**

   ```bash
   scp -r username@server_address:/home/groups/rsu/your_username/ /path/to/local/directory/
-r: This flag tells scp to copy directories recursively, meaning it will copy all files and sub-directories within the source directory.
Important:

Make sure you have SSH access enabled on the remote server.
You might be prompted for your password when connecting to the server.
Additional Notes:

You can also use scp to copy files from your local machine to the remote server. Just swap the source and destination paths in the command.


# FastQC Quality Control with WDL & Singularity 

Streamline your sequencing data quality control with this easy-to-use WDL (Workflow Description Language) sub-workflow! Powered by FastQC and Singularity containers, you can ensure consistent and reliable QC analysis across different environments.

**Author:** Akbar Abayev, RSU Bioinformatics Group

## ✨ Key Features

* **Reproducibility:** Singularity containers guarantee that your analysis runs the same way every time, no matter where you execute it.
* **Portability:** Easily share and deploy your QC workflow across various computing platforms.
* **Automation:** Cromwell handles the workflow execution, freeing you from manual intervention.
* **Customization:** Adapt input parameters to fit your specific data and analysis requirements.

## 📁 Directory Structure

*   **WDL:**
    *   `cromwell-fixed.conf`: Configuration settings for the Cromwell engine.
    *   `fastqc_subworkflow.wdl`: Defines the FastQC workflow steps and logic.
    *   `fastqc_workflow_inputs.json`: Example input parameters to get you started.
*   **fastqc:**
    *   `install_fastqc.sh`: Script to install FastQC.
    *   `run_fastqc.sh`: Script to test your FastQC and Singularity setup.

## 🛠️ System Prerequisites 

Before diving in, make sure you have the following tools ready:

*   **Singularity:** v3.11.4 or later. Learn more about Singularity: [Introduction to Singularity Containers](https://bioinformaticsworkbook.org/Appendix/HPC/Containers/Intro_Singularity.html#gsc.tab=0)
*   **Java JDK:** v21.0.2 or compatible.
*   **Cromwell:** An open-source workflow management system. 
    *   [Introduction to Cromwell](https://cromwell.readthedocs.io/en/stable/tutorials/FiveMinuteIntro/)
    *   [Cromwell Configuration for Singularity](https://cromwell.readthedocs.io/en/stable/getting_started/#using-singularity)
*   **Docker:** (Optional) If you want to build your own FastQC image.

## 🚀 Getting Started

### 1. Load Modules

```bash
module avail
module load singularity/3.11.4 java/jdk-21.0.2
```

### 2. Pulling and convereting docker image into the singularity format

Pull the respective Docker image from the DockerHub and convert it into a Singularity format (*.sif). In this example, the Docker image is located in a private repository and requires authentication, meaning that you need to provide the appropriate authentication credentials to Singularity. You can use environment variables or Singularity's --docker-login option to provide Docker login credentials. For example:
```bash
export DOCKER_USERNAME=<yourusername>
export DOCKER_PASSWORD=<yourpassword> 
singularity pull --docker-login docker://biocontainers/fastqc:v0.11.9_cv8
```

### 3. FastQC setup and test

1. Navigate to the fastqc directory:
```bash
cd fastqc
```

2. Install FastQC:
```bash
bash install_fastqc.sh
```

3. Test your Setup
```bash
bash run_fastqc.sh
```

### 4. Run the Workflow

1. Navigate to the WDL directory:
```bash
cd ../WDL
```

2. Customize the input parameters in fastqc_workflow_inputs.json. Make sure to provide the correct paths to your input files.

3. Execute the workflow:
```bash
java -Dconfig.file=cromwell-fixed.conf -jar cromwell-87.jar run fastqc_subworkflow.wdl --inputs fastqc_workflow_inputs.json
```

### 5. FastQC Output
The FastQC workflow generates two types of output files:

1. **.zip File:** This is a compressed archive containing basic statistics and quality metrics about the sequence data. It includes files like `fastqc_data.txt` with detailed metrics and `summary.txt` with a quick overview.

2. **.html File:** This is a report file that provides a visual summary of the quality checks, which can be viewed in any web browser.

To unzip the `.zip` file, use the following command in the terminal:
```bash
unzip filename.zip
```
Replace `filename.zip` with the actual name of the `.zip` file.


### What is WDL?

WDL (Workflow Description Language) is a language used to describe data processing workflows. It provides a way to specify tasks and their dependencies in a structured format, making it easier to automate and manage complex data analysis pipelines. WDL is often used with Cromwell, an open-source workflow management system that runs WDL scripts.

### Why Do We Need These Three Files?

1. **cromwell-fixed.conf**
   - **Purpose**: This file contains configuration settings for the Cromwell engine. It includes information such as backend configurations, database settings, and runtime options.
   - **Importance**: Proper configuration ensures that Cromwell can correctly execute workflows using the specified computational resources and settings.

2. **fastqc_subworkflow.wdl**
   - **Purpose**: This is the main WDL script that defines the sub-workflow for running FastQC. It specifies the tasks to be executed, the order in which they should be run, and the inputs/outputs for each task.
   - **Importance**: The WDL file is the core of the workflow, describing the steps and logic of the data processing pipeline. It allows for reproducibility and scalability of the analysis.

3. **fastqc_workflow_inputs.json**
   - **Purpose**: This JSON file provides the input parameters required by the WDL script. It includes paths to input data files, parameter values, and other necessary settings.
   - **Importance**: The inputs file makes the workflow flexible and reusable by allowing users to provide different input values without modifying the WDL script. It separates the workflow logic from the specific data and parameters used in each run.

These three files work together to ensure that the FastQC sub-workflow is properly defined, configured, and executed, providing a robust and reproducible data analysis pipeline.

### 🤔 Troubleshooting

If you run into any issues, verify the following:

*   **Modules:** Make sure the correct Singularity and Java modules are loaded.
*   **File Paths:** Double-check the paths in your `fastqc_workflow_inputs.json` file.
*   **FastQC:** Ensure FastQC was installed and tested successfully using the `run_fastqc.sh` script.
*   **Cromwell:** Review your Cromwell configuration for any errors.

For further assistance, consult the documentation for:
*   [Cromwell](https://cromwell.readthedocs.io/en/stable/)
*   [FastQC](https://www.bioinformatics.babraham.ac.uk/projects/fastqc/)


## 🤝 Contributing

Your contributions are valued! Please open issues or submit pull requests to enhance this workflow.

In case of any questions/concerns my email address: akbaba@rsu.lv

Happy QC-ing! 🎉


