
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
	Array[File] output_html = [fastqc_task_R1.output_html, fastqc_task_R2.output_html]
    Array[File] output_zip = [fastqc_task_R1.output_zip, fastqc_task_R2.output_zip]
    }
}

task pull_fastqc_image {
    input {}

    command <<<
        singularity pull docker://biocontainers/fastqc:v0.11.9_cv8
        mv fastqc_v0.11.9_cv8.sif /path-to-your-.sif/fastqc_v0.11.9_cv8.sif
    >>>

    output {
	File singularity_image = "/path-to-your-.sif/fastqc_v0.11.9_cv8.sif"
    }

    runtime {
	singularity: "/path-to-your-.sif/fastqc_v0.11.9_cv8.sif"
    }
}

task fastqc_task {
    input {
	File input_fastq
    File singularity_image
    }

    command <<<
        mkdir -p fastqc_results
        singularity exec ${singularity_image} fastqc ${input_fastq}

        # Explicitly copy output files to prevent hard links
        cp ${basename(input_fastq)}_fastqc.html fastqc_results/
        cp ${basename(input_fastq)}_fastqc.zip fastqc_results/
    >>>

    output {
	File output_html = "fastqc_results/${basename(input_fastq)}_fastqc.html"
        File output_zip = "fastqc_results/${basename(input_fastq)}_fastqc.zip"
    }

    runtime {
	singularity: "${singularity_image}"
    }
}
