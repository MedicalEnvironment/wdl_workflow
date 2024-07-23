
#Main error: 
#[akbar01@ui-2 execution]$ cat stderr
#Error for command "exec": requires at least 2 arg(s), only received 1

#Usage:
#  singularity [global options...] exec [exec options...] <container> <command>

#Run 'singularity --help' for more detailed usage information.
#/mnt/beegfs2/home/akbar01/cromwell-executions/fastqc_workflow/e3294d64-11f2-4e94-bfba-b236e9b41e6b/call-fastqc_task_R2/execution/script: line 30: ${basename(input_fastq)}_fastqc.html: bad substitution

version 1.0

workflow fastqc_workflow {
    input {
        File input_fastq_R1
        File input_fastq_R2
    }

    call pull_fastqc_image

    call fastqc_task as fastqc_task_R1 {
        input:
            input_fastq = input_fastq_R1,
            singularity_image = pull_fastqc_image.singularity_image
    }

    call fastqc_task as fastqc_task_R2 {
        input:
            input_fastq = input_fastq_R2,
            singularity_image = pull_fastqc_image.singularity_image
    }

    output {
    File output_html_R1 = "/path-to-cromwell-output/cromwell-output/${fastqc_task_R1.output_html}"
    File output_zip_R1 = "/path-to-cromwell-output/cromwell-output/${fastqc_task_R1.output_zip}"
    File output_html_R2 = "/path-to-cromwell-output/cromwell-output/${fastqc_task_R2.output_html}"
    File output_zip_R2 = "/path-to-cromwell-output/cromwell-output/${fastqc_task_R2.output_zip}"
}

}

task pull_fastqc_image {
    input {}

    #to change HOME directory to the existing one on a server
    command {
        singularity pull docker://biocontainers/fastqc:v0.11.9_cv8
        mv fastqc_v0.11.9_cv8.sif ${HOME}/.singularity/cache/oci-tmp/fastqc_v0.11.9_cv8.sif 
    } 
    

    output {
        File singularity_image = "${HOME}/.singularity/cache/oci-tmp/fastqc_v0.11.9_cv8.sif" 
    }   

    runtime {
        docker: "singularityware/singularity:3.5"
        memory: "4G" #some issues seems to be accured here, even though with no "GB" syntax
        cpu: 1
    }
}

task fastqc_task {
    input {
        File input_fastq
        File singularity_image
    }   

    command {
        singularity exec ${singularity_image} fastqc ${input_fastq}
    }

    output {
        File output_html = "${basename(input_fastq)}_fastqc.html"
        File output_zip = "${basename(input_fastq)}_fastqc.zip"
    }

    runtime {
        singularity: "fastqc_v0.11.9_cv8.sif"
        memory: "4G" #some issues seems to be accured here, even though with no "GB" string 
        cpu: 2
    }
}
