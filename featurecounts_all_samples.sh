#!/bin/bash -l

#$ -N featurecounts_all
#$ -o featurecounts_output.log
#$ -e featurecounts_error.log
#$ -pe omp 8

# Load the required module
module load subread

# Directory containing STAR output BAM files
STAR_OUTPUT_DIR="/projectnb/evolution/bergamo/STAR"

# GTF annotation file
GTF_FILE="/projectnb/evolution/bergamo/annotations/genes.gtf"

# Output directory
OUTPUT_DIR="/projectnb/evolution/bergamo/featureCounts"
mkdir -p "$OUTPUT_DIR"

# Find all BAM files sorted by coordinate
bam_files=$(find "$STAR_OUTPUT_DIR" -name "*Aligned.sortedByCoord.out.bam" | sort)

# Output file
OUTPUT_FILE="${OUTPUT_DIR}/all_samples_counts.txt"

# Run featureCounts on all BAM files at once
featureCounts -T 8 \
  -a "$GTF_FILE" \
  -o "$OUTPUT_FILE" \
  -p -B -C \
  $bam_files

echo "Quantification completed for all samples. Output saved to $OUTPUT_FILE"
