import os
os.environ["FSLOUTPUTTYPE"] = "NIFTI_GZ"

SUBJECTS = ["sub-01", "sub-02", "sub-03"]
TEMPLATE = "resources/mni152.nii.gz"

# STEP 7: Adding a target rule
# We want to ensure EVERY subject gets a 'mean.txt' file
rule all:
    input:
        expand("stats/{subject}_mean.txt", subject=SUBJECTS)

# STEP 1 & 2: Mapping & Generalizing
rule align_to_standard:
    input:
        src = "data/{subject}/anat/{subject}_T1w.nii.gz",
        ref = TEMPLATE
    output:
        "proc/{subject}_std.nii.gz"
    shell:
        "flirt -in {input.src} -ref {input.ref} -out {output}"

# STEP 3: Sorting (Thresholding)
rule clean_image:
    input:
        "proc/{subject}_std.nii.gz"
    output:
        "proc/{subject}_clean.nii.gz"
    shell:
        "fslmaths {input} -thr 20 {output}"

# STEP 4: Indexing / Stats
rule get_stats:
    input:
        "proc/{subject}_clean.nii.gz"
    output:
        "stats/{subject}_mean.txt"
    shell:
        "fslstats {input} -M > {output}"