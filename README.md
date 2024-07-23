# WDL Sub-Workflow for FastQC Analysis with Singularity

This repository facilitates the quality control (QC) of sequencing data using the FastQC tool within a streamlined WDL (Workflow Description Language) sub-workflow. By integrating Singularity containerization via the Cromwll engine, this approach ensures reproducibility and portability across various computing environments. The workflow is orchestrated using the Cromwell execution engine.

**Author:** Akbar Abayev, RSU Bioinformatics Group

## Overview

This project was developed as part of focusing on the deployment of WDL sub-workflows with FastQC. The primary goal is to provide a robust and efficient solution for quality assessment of sequencing data.

## Directory Structure

*   **WDL:**
    *   `cromwell.conf`: Configuration file for the Cromwell workflow engine.
    *   `fastqc_subworkflow.wdl`: WDL file defining the FastQC sub-workflow.
    *   `fastqc_workflow_inputs.json`: Example input parameters in JSON format for the workflow.

*   **fastqc:**
    *   `install_fastqc.sh`: Bash script to automate the installation of FastQC.
    *   `run_fastqc.sh`: Script to test the proper functioning of Bash, Singularity, and the FastQC tool.

## Prerequisites

To successfully run this workflow, ensure the following are installed on your system:

*   **Singularity:** Version 3.11.4 or later.
    *   [Introduction to Singularity Containers](https://bioinformaticsworkbook.org/Appendix/HPC/Containers/Intro_Singularity.html#gsc.tab=0)
*   **Java JDK:** Version 21.0.2 or compatible.
*   **Cromwell:** Refer to the documentation for installation and configuration instructions.
    *   [Introduction to Cromwell](https://cromwell.readthedocs.io/en/stable/tutorials/FiveMinuteIntro/)
    *   [Cromwell Configuration for Singularity](https://cromwell.readthedocs.io/en/stable/getting_started/#using-singularity)
*   **Docker:** Required for building the Docker image (optional). If you already have a FastQC Docker image, you can skip this.

## Installation and Setup

### 1. Load Modules

Load the required modules:

```bash
module avail
module load singularity/3.11.4 java/jdk-21.0.2
```

### 2. Running the fastqc scripts

Make sure that you have checked the scripts and have valid directories for input, output and installation processes.

Run the following commands in order to install and test the functionality of fastqc and singularity.

```bash
bash install_fastqc.sh
bash run_fastqc.sh
```

### 3. WDL and Its Components

### What is WDL?

WDL (Workflow Description Language) is a language used to describe data processing workflows. It provides a way to specify tasks and their dependencies in a structured format, making it easier to automate and manage complex data analysis pipelines. WDL is often used with Cromwell, an open-source workflow management system that runs WDL scripts.

### Why Do We Need These Three Files?

1. **cromwell.conf**
   - **Purpose**: This file contains configuration settings for the Cromwell engine. It includes information such as backend configurations, database settings, and runtime options.
   - **Importance**: Proper configuration ensures that Cromwell can correctly execute workflows using the specified computational resources and settings.

2. **fastqc_subworkflow.wdl**
   - **Purpose**: This is the main WDL script that defines the sub-workflow for running FastQC. It specifies the tasks to be executed, the order in which they should be run, and the inputs/outputs for each task.
   - **Importance**: The WDL file is the core of the workflow, describing the steps and logic of the data processing pipeline. It allows for reproducibility and scalability of the analysis.

3. **fastqc_workflow_inputs.json**
   - **Purpose**: This JSON file provides the input parameters required by the WDL script. It includes paths to input data files, parameter values, and other necessary settings.
   - **Importance**: The inputs file makes the workflow flexible and reusable by allowing users to provide different input values without modifying the WDL script. It separates the workflow logic from the specific data and parameters used in each run.

These three files work together to ensure that the FastQC sub-workflow is properly defined, configured, and executed, providing a robust and reproducible data analysis pipeline.

### 4. Final results

Make sure that you provided valid directories for all of your scripts and files. The output directory supposed to contain only .zip and .html formats.

If you'll have any concerns or questions, please do not hesitate and feel free to ask questions to me via email or this repository akbaba@rsu.lv.

Happy coding and have a great day y'all!

