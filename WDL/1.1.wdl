version 1.0

task pullFastQCDocker {
    command {
        singularity pull docker://biocontainers/fastqc:v0.11.9_cv8
    }
    output {
        File imageFile = "fastqc_v0.11.9_cv8.sif"
    }
}

task runFastQC {
    input {
        File imageFile
        String fastqFile
        String dataDir
    }

    String baseName = sub(fastqFile, "\\.fastq\\.gz$", "")
    
    command {
        # Set locale to avoid warnings
        export LC_ALL=C
        export LANG=C
        
        # Use your own directory for output
        singularity run -B ${dataDir}:/data ${imageFile} fastqc /data/${fastqFile} -o /home_beegfs/akbar01/data/fastqc_output/ 
    }
    
    output {
        File fastqcOutput = "/home_beegfs/akbar01/data/fastqc_output/${baseName}_fastqc.zip"  # provide your own directory in order to get the declared output file
    }
}


workflow fastQCWorkflow {
    input {
        String dataDir
        Array[String] fastqFiles
    }

    call pullFastQCDocker

    scatter(file in fastqFiles) {
        call runFastQC {
            input:
                imageFile = pullFastQCDocker.imageFile,
                fastqFile = file,
                dataDir = dataDir
        }
    }

    output {
        Array[File] outputFiles = runFastQC.fastqcOutput
    }
}