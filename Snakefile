import nibabel as nib
import numpy as np
from nilearn import image, plotting

SUBJECTS = ["sub-01", "sub-02", "sub-03"]
TEMPLATE = "resources/mni152.nii.gz"

rule all:
    input:
        expand("stats/{subject}_mean.txt", subject=SUBJECTS)

# STEP 1 & 2: Alignment (Resampling to Template Space)
rule align_to_standard:
    input:
        src = "data/{subject}/anat/{subject}_T1w.nii.gz",
        ref = TEMPLATE
    output:
        "proc/{subject}_std.nii.gz"
    run:
        resampled_img = image.resample_to_img(source_img=input.src, target_img=input.ref)
        resampled_img.to_filename(output[0])

# STEP 3: Thresholding
rule clean_image:
    input:
        "proc/{subject}_std.nii.gz"
    output:
        "proc/{subject}_clean.nii.gz"
    params:
        threshold = 20
    run:
        # threshold_img sets all values below the param to zero
        thresholded_img = image.threshold_img(input[0], threshold=params.threshold)
        thresholded_img.to_filename(output[0])

# STEP 4: Stats
rule get_stats:
    input:
        "proc/{subject}_clean.nii.gz"
    output:
        "stats/{subject}_mean.txt"
    run:
        img = nib.load(input[0])
        data = img.get_fdata()
        # Calculate mean of non-zero voxel
        mean_val = np.mean(data[data > 0])
        with open(output[0], "w") as f:
            f.write(str(mean_val))