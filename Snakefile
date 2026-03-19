# 1. Define your subjects based on your GitHub folder names
# In a real tutorial, you'd show how SnakeBIDS automates this!
SUBJECTS = ["01", "02", "03"]

# 2. The Target Rule (The "Order" at the Restaurant)
# This rule tells Snakemake exactly what files we want at the very end.
rule all:
    input:
        expand("qc/{subject}_report.txt", subject=SUBJECTS)

# 3. Rule: Brain Extraction (The "Ingredient")
# We use a wildcard {subject} so this 1 rule handles everyone.
rule brain_extract:
    input:
        "data/sub-{subject}/anat/sub-{subject}_T1w.nii.gz"
    output:
        "proc/{subject}_brain.nii.gz"
    shell:
        # We use 'touch' to simulate the process for the tutorial
        "echo 'Extracting brain from {input}...' && touch {output}"

# 4. Rule: Quality Control (The "Plating")
# This rule 'chains' to the one above by asking for its output as input.
rule generate_qc:
    input:
        "proc/{subject}_brain.nii.gz"
    output:
        "qc/{subject}_report.txt"
    shell:
        "echo 'QC Report for {wildcards.subject}: Brain extraction successful.' > {output}"