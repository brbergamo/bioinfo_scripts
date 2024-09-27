#!/bin/bash -l

#$ -t 1-103
#$ -N genome_index_job
#$ -o output.log
#$ -e error.log
#$ -pe omp 16

# loading tool
module load star

# defining environment variables
FASTQDIR="/projectnb/evolution/bergamo/mair"
GENOMEDIR="/projectnb/evolution/bergamo/STAR/genome_index_output"

read1_paths=($(find $FASTQDIR -regextype posix-egrep -regex ".*_R1_001\.(fastq|fastq\.gz)" | sort))
read2_paths=($(find $FASTQDIR -regextype posix-egrep -regex ".*_R2_001\.(fastq|fastq\.gz)" | sort))

# pegando caminho das amostras correspondentes ao ID do job
read1=${read1_paths[$((SGE_TASK_ID-1))]}
read2=${read2_paths[$((SGE_TASK_ID-1))]}


# Extracting the common prefix (before _R1 or _R2)
prefix=$(basename "$read1" | sed 's/_R1_001.*//')

# Defining the output directory for each sample
output_dir="/projectnb/evolution/bergamo/STAR/${prefix}"
mkdir -p "$output_dir"

# verificando as reads
echo "Processando: $read1 e $read2"

# verifica se eh compactado
if [[ $read1 == *.gz ]]; then
    readFilesCommand="--readFilesCommand zcat"
else
    readFilesCommand=""
fi

# comando STAR
STAR --runThreadN 16 \
--genomeDir $GENOMEDIR \
--readFilesIn $read1 $read2 \
$readFilesCommand \
--outFileNamePrefix "${output_dir}/${prefix}_" \
--outSAMtype BAM SortedByCoordinate
