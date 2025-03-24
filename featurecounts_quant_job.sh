#!/bin/bash -l

#$ -t 1-103
#$ -N featurecounts_job
#$ -o featurecounts_output.log
#$ -e featurecounts_error.log
#$ -pe omp 8

# Load the required module
module load subread

# Directory containing STAR output BAM files
STAR_OUTPUT_DIR="/projectnb/evolution/bergamo/STAR"

# GTF annotation file
GTF_FILE="/projectnb/evolution/bergamo/annotations/genes.gtf"

# Sorted BAM files from STAR
bam_files=($(find $STAR_OUTPUT_DIR -name "*Aligned.sortedByCoord.out.bam" | sort))

# Selecting the BAM file corresponding to the current job ID
bam_file=${bam_files[$((SGE_TASK_ID-1))]}

# Extracting sample name prefix
prefix=$(basename "$bam_file" | sed 's/_Aligned\.sortedByCoord\.out\.bam//')

# Defining output directory
output_dir="/projectnb/evolution/bergamo/featureCounts"
mkdir -p "$output_dir"

# Running featureCounts
featureCounts -T 8 \
  -a "$GTF_FILE" \
  -o "${output_dir}/${prefix}_counts.txt" \
  -p -B -C \
  "$bam_file"

echo "Quantification completed for $prefix"
