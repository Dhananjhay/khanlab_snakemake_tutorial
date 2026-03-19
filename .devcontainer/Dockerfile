FROM mcr.microsoft.com/devcontainers/base:ubuntu-24.04

# Install Miniforge (conda + mamba) and Snakemake
RUN apt-get update && export DEBIAN_FRONTEND=noninteractive \
    && apt-get -y install --no-install-recommends wget ca-certificates \
    && wget -q "https://github.com/conda-forge/miniforge/releases/latest/download/Miniforge3-Linux-x86_64.sh" -O /tmp/miniforge.sh \
    && bash /tmp/miniforge.sh -b -p /opt/conda \
    && rm /tmp/miniforge.sh \
    && /opt/conda/bin/conda clean -afy \
    && ln -s /opt/conda/bin/conda /usr/local/bin/conda \
    && ln -s /opt/conda/bin/mamba /usr/local/bin/mamba

# Install Snakemake via mamba
RUN /opt/conda/bin/mamba install -y -n base -c conda-forge -c bioconda snakemake \
    && /opt/conda/bin/conda clean -afy \
    && ln -s /opt/conda/bin/snakemake /usr/local/bin/snakemake

# Make conda available to all users
ENV PATH="/opt/conda/bin:$PATH"
