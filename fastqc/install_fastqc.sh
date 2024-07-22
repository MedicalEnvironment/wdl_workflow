#!/bin/sh

# TITLE: install_fastqc.sh 

# AUTHOR: Baiba Vilne

# DATE:  2023-11-28

# DESCRIPTION:

# This script installs the FastQC tool in a user provided directory
# [https://www.bioinformatics.babraham.ac.uk/projects/fastqc/]
# FastQC is a quality control tool for high throughput sequence data 
# that can import data from BAM, SAM or FastQ files and provide a 
# quick overview of potential problems. FastQC can generate summary 
# graphs and tables to quickly assess the data quality, such as per 
# base sequence quality, per sequence quality scores, per base sequence 
# content, per sequence GC content, per base N content, sequence length 
# distribution, sequence duplication levels, overrepresented sequences, 
# adapter content, and kmer content. FastQC can export the results to an 
# HTML based permanent report that can be viewed in a web browser.

# USAGE: bash install_fastqc.sh $HOME/tools

echo -e "\n The date and time of the script execution: \n"
echo $(date)


# INSTRUCTIONS:

# First, you need to make sure you have Java installed on your system, 
# as FastQC is a Java application. You can check the version of Java 
# by running in the terminal. If you don’t have Java, you can install it 
# from [https://adoptium.net/].

echo -e "\n The following Java version has been installed on your system: \n"
echo -e "\n ******************************************************** \n"
java -version
echo -e "\n ******************************************************** \n"

# Check if the directory is provided, where to download the FastQC tool:
if [[ -z $1 ]]; then
    echo -e "\n USAGE: bash install_fastqc.sh [directory]"
    echo -e "\n Please provide the directory where to download the FastQC tool\n \
as a command-line argument.\n"
    exit 1
fi

# Create the specified directory if it doesn't exist
mkdir -p "$1"
chmod a+rwx "$1"
cd "$1"


# Download the FastQC zip file from the official website. You can use the wget command to 
# download it directly from the terminal. For example, to download the latest version as
# of 2023-11-28 (0.12.1) for Windows or Linux, you can run 

echo -e "\n Downloading the FastQC zip file from the official website: \n"
echo -e "\n ******************************************************** \n"
wget https://www.bioinformatics.babraham.ac.uk/projects/fastqc/fastqc_v0.12.1.zip --no-check-certificate ./
chmod a+rwx fastqc_v0.12.1.zip
echo -e "\n ******************************************************** \n"


# Then, you need to unzip the downloaded file. You can use the unzip and mv commands for this. 
echo -e "\n Unzipping the downloaded file. \n"
unzip fastqc_v0.12.1.zip 


# You need to make the FastQC executable 
echo -e "\n Making the unzipped directory executable. \n"
chmod a+rwx FastQC
cd FastQC
chmod a+rwx *

# Finally, add the FastQC directory to your system's PATH variable. This step allows you to run 
# FastQC from any location in the command line. Run the following command:
echo -e "\n Adding the FastQC directory [$1/FastQC/] to your system's PATH variable. \n"
export PATH=$1/FastQC/:$PATH
echo 'export PATH=$1/FastQC/:$PATH' >> ~/.bashrc

# Test the FastQC installation by running the following commands:
echo -e "\n Testing the FastQC installation: \n"
echo -e "\n ******************************************************** \n"
fastqc --version
fastqc --help
echo -e "\n ******************************************************** \n"

# Clean up the downloaded zip file
echo -e "\n Cleaning up the downloaded zip file. \n"
cd "$1"
rm fastqc_v0.12.1.zip 
