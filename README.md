# bioinfo_scripts

A growing collection of Bash and command-line scripts for common bioinformatics workflows.  
This repository includes HPC-ready scripts designed to automate and streamline the analysis of high-throughput sequencing data. While it currently includes RNA-Seq processing steps, it will be expanded to cover additional areas such as variant calling, metagenomics, and functional analysis.

## Current Contents

### RNA-Seq
Scripts for processing bulk RNA-Seq data on a high-performance computing (HPC) cluster.

- **`star_alignment.sh`**  
  Aligns paired-end RNA-Seq reads to a reference genome using [STAR](https://github.com/alexdobin/STAR), a splice-aware aligner. Handles automatic detection of input files, job array indexing, and parallel execution.

- **`featurecounts_all_samples.sh`**  
  Runs [featureCounts](http://bioinf.wehi.edu.au/featureCounts/) to quantify gene-level expression from all aligned BAM files in one command. Outputs a single count matrix ready for downstream differential expression analysis (e.g., with DESeq2).

## Requirements

- Linux environment
- HPC scheduler (e.g., SGE)
- Tools used:
  - `STAR`
  - `featureCounts` (from the `subread` package)
  - `bash`, `find`, `zcat`, etc.
---

Feel free to fork or adapt any script for your own projects. Contributions are welcome!
