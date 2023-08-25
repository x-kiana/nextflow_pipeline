#!/bin/bash
## This install script is currently being developed and will be added in later versions
mkdir -p tools
cd tools
## Install nextflow
# Get newest java: 
wget -P $PWD/java https://download.oracle.com/java/20/latest/jdk-20_linux-x64_bin.tar.gz

# Unzip
tar -zxvf $PWD/java/jdk-20_linux-x64_bin.tar.gz

# Add JAVA_HOME to your ~/.bashrc or ~/.bash_profile

sed -i "$a export JAVA_HOME=/mnt/common/Precision/NextFlow/June2023/jdk-20.0.1/bin" ~/.bashrc
sed -i "$a PATH="$JAVA_HOME:$HOME/.local/bin:$HOME/bin:$PATH"" ~/.bashrc
sed -i "$a export PATH" ~/.bashrc

# Source your ~/.bashrc

source ~/.bashrc

mkdir -p nextflow
cd nextflow
# Now you can grab nextflow (or just use it)

curl -s https://get.nextflow.io | bash

# chmod on the nextflow executable

chmod ugo=rwx ./nextflow

# go back to the tools directory
cd ../

## Install miniconda

wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh

bash Miniconda3-latest-Linux-x86_64.sh -b -p $PWD/miniconda3

## Pull DeepVariant
## activate/install singularity
module load singularity

mkdir -p singularity
cd singularity

singularity pull docker://google/deepvariant:1.4.0

## Pull GLNexus
singularity pull docker://ghcr.io/dnanexus-rnd/glnexus:v1.4.3

cd ../
## Pull exomiser

## Pull reference genome & index
mkdir -p reference_genome
cd reference_genome

wget ftp://ftp.ensembl.org/pub/release-96/fasta/homo_sapiens/dna/Homo_sapiens.GRCh38.dna_sm.primary_assembly.fa.gz
gunzip -c Homo_sapiens.GRCh38.dna_sm.primary_assembly.fa.gz > GRCh38-lite.fa

# needs to activate conda    
samtools faidx GRCh38-lite.fa
bwa index GRCh38-lite.fa

## Pull databases
