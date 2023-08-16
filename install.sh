#!/bin/bash
## This install script is currently being developed and will be added in later versions
mkdir -p tools
cd tools
## Install nextflow

function get_java() {
# Get newest java: 
wget -P $PWD/java https://download.oracle.com/java/20/latest/jdk-20_linux-x64_bin.tar.gz

# Unzip
tar -zxvf $PWD/java/jdk-20_linux-x64_bin.tar.gz

# Add JAVA_HOME to your ~/.bashrc or ~/.bash_profile

sed -i "$a export JAVA_HOME=$PWD/java/jdk-20.0.1/bin" ~/.bashrc
sed -i "$a PATH="$JAVA_HOME:$HOME/.local/bin:$HOME/bin:$PATH"" ~/.bashrc
sed -i "$a export PATH" ~/.bashrc

# Source your ~/.bashrc

source ~/.bashrc
}

function get_nextflow() {
mkdir -p nextflow
cd nextflow
# Now you can grab nextflow (or just use it)

curl -s https://get.nextflow.io | bash

# chmod on the nextflow executable

chmod ugo=rwx ./nextflow

# go back to the tools directory
cd ../
}

function get_miniconda() {
## Install miniconda

wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh

bash Miniconda3-latest-Linux-x86_64.sh -b -p $PWD/miniconda3
}

function load_singularity() {
## activate/install singularity
module load singularity
mkdir -p singularity
cd singularity
}

function get_deepvariant() {
## Pull DeepVariant
singularity pull docker://google/deepvariant:1.4.0

cd ../
}

function get_glnexus() {
## Pull GLNexus
singularity pull docker://ghcr.io/dnanexus-rnd/glnexus:v1.4.3

cd ../
}

function activate_conda() {
source $PWD/miniconda/etc/profile.d/conda.sh
cd ../
conda env create -  -f $PWD/scripts/GenomeAnalysisGAM.yml 
conda activate GenomeAnalysisGAM
}

function get_refgenome() {
## Pull reference genome & index
mkdir -p reference_genome
cd reference_genome

wget ftp://ftp.ensembl.org/pub/release-96/fasta/homo_sapiens/dna/Homo_sapiens.GRCh38.dna_sm.primary_assembly.fa.gz
gunzip -c Homo_sapiens.GRCh38.dna_sm.primary_assembly.fa.gz > GRCh38-lite.fa

# needs to activate conda    
samtools faidx GRCh38-lite.fa
bwa index GRCh38-lite.fa
}

## Pull databases
## Pull exomiser
## call all functions in main
