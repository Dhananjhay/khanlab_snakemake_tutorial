FROM snakemake/snakemake:stable
ADD environment.yaml .
RUN conda env update -n base -f environment.yaml
RUN mkdir -p /tmp/conda
ENV CONDA_PKGS_DIRS /tmp/conda