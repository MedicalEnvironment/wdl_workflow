# Deploying a WDL Sub-Workflow with FastQC and Singularity

This repository guides you through deploying a WDL sub-workflow using the FastQC Docker image, converted to Singularity format. The workflow will be executed using Cromwell.

## Directory Structure

The project directory is organized as follows:


## Prerequisites

Before running the WDL sub-workflow, ensure that the following prerequisites are met:

1. **Singularity**: Make sure Singularity is installed on your cluster.
2. **Java Runtime Environment (JRE)**: Required for running Cromwell.
3. **Cromwell**: Cromwell is needed to execute WDL scripts. You can download and configure it as follows:

   - [Cromwell GitHub Repository](https://github.com/broadinstitute/cromwell)
   - [Cromwell Configuration for Singularity](https://cromwell.readthedocs.io/en/stable/getting-started/#using-singularity)

## Setup Instructions

### 1. Install Dependencies

Ensure that all necessary dependencies are installed on your cluster, including the FastQC framework and the Singularity container image. Additionally, verify that Cromwell is installed.

#### a. Load Modules

To load and verify the required modules, use the following commands (in my case it's {singularity/3.11.4} and {java/jdk-21.0.2}):

```bash
module avail
module load {singularity/3.11.4} {java/jdk-21.0.2}
