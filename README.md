# Directories

WDL/
   /cromwell.conf
   /fastqc_subworkflow.wdl
   /fastqc_workflow_inputs.json
All the necessary files to run .wdl file are located here so you could run the sub-workflow with no issues. 

fastqc/
   /install_fastqc.sh
   /run_fastqc.sh
FastQC installation script and test to check the functionality of bash, singularity and fastqc.

# Deploying a WDL Sub-Workflow with FastQC and Singularity

This repository guides you through deploying a WDL sub-workflow using the FastQC Docker image, converted to Singularity format. The workflow will be executed using Cromwell.

## Directory Structure

The project directory is organized as follows:


## Prerequisites

Before running the WDL sub-workflow, ensure that the following prerequisites are met:

1. **Singularity**: Make sure Singularity is installed on your cluster.
2. **FastQC**: Install via the script in the repository.
3. **DockerHUB image**: Make sure that you provided pullable tag in the workflow and scripts.
4. **Java Runtime Environment (JRE)**: Required for running Cromwell.
5. **Cromwell**: Cromwell is needed to execute WDL scripts. You can download and configure it as follows:

   - [Introduction to Cromwell](https://cromwell.readthedocs.io/en/stable/tutorials/FiveMinuteIntro/)
   - [Cromwell Configuration for Singularity](https://cromwell.readthedocs.io/en/stable/getting-started/#using-singularity)

## Setup Instructions

### 1. Install Dependencies

Ensure that all necessary dependencies are installed on your cluster, including the FastQC framework and the Singularity container image. Additionally, verify that Cromwell is installed.

#### a. Load Modules

To load and verify the required modules, use the following commands (in my case it's {singularity/3.11.4} and {java/jdk-21.0.2}):

```bash
module avail
module load {singularity/3.11.4} {java/jdk-21.0.2}
