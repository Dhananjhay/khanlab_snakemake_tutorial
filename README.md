# 🧠 Snakemake for Neuroimaging
**A Khan Lab Brainhack Tutorial**

This workshop introduces you to building reproducible neuroimaging pipelines. We will use **Snakemake** to orchestrate a workflow that performs image resampling, thresholding, and statistical extraction using **Nilearn** and **Nibabel**.

---

## 🚀 Quick Start: Environment Setup

### 1. Install [Pixi](https://pixi.prefix.dev/latest/installation/)

Choose the command for your operating system:

**macOS / Linux / WSL2**:

```bash
curl -fsSL https://pixi.sh/install.sh | bash
```

**Windows**

```bash
powershell -ExecutionPolicy Bypass -c "irm -useb https://pixi.sh/install.ps1 | iex"
```

### 2. Clone this Tutorial
```bash
git clone https://github.com/Dhananjhay/khanlab_snakemake_tutorial.git
cd khanlab_snakemake_tutorial
```

### 3. Enter the Environment
```bash
pixi shell
```
