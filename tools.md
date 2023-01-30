---
layout: page
title: Tools
sidebar_link: true
---

## Data analysis tools and pipelines

Many tools, programs, pipelines, and software suites are used in the analysis of ancient biomolecules. Below are a collection of commonly used software resources, including with links for their download. If you have add additional resources to suggest, please send your suggestions to webmaster@isbarch.org.
- [Ancient DNA](#ancient-dna)
- [Ancient Proteins](#ancient-proteins)
- [Stable Isotopes](#stable-isotopes)

### Ancient DNA

**Multipurpose GUI platforms**
- [Geneious](https://www.geneious.com) is a commercially available software suite for analyzing genomic data 
- [CLC Genomics Workbench](https://www.qiagenbioinformatics.com/products/clc-genomics-workbench/) is a commercially available software suite for analyzing genomic data 

**Initial data handling and quality assessment**
- [nf-core/eager](https://github.com/nf-core/eager) (Efficient Ancient GenomE Reconstruction) is a GUI wrapper software for quality filtering and mapping sequence data to a reference sequence
- [paleoMIX](https://github.com/MikkelSchubert/paleomix) is a pipeline for quality filtering and mapping ancient DNA data to a reference sequence 
- [PreSeq](https://github.com/smithlabcode/preseq) is a tool that estimates DNA library complexity, essentially allowing users to model the costs and genome recovery potential of a given archaeological sample

**DNA sequence alignment**
- [BWA](http://bio-bwa.sourceforge.net/) (Burrows-Wheeler Aligner) aligns DNA sequences to a reference sequence. BWA aln and samse/sampe are commonly chosen algorithms for ancient DNA analysis
- [Bowtie2](http://bowtie-bio.sourceforge.net/bowtie2/index.shtml) aligns DNA sequences to a reference sequence

**DNA sequence assembly**
- [MEGAHIT](https://www.metagenomics.wiki/tools/assembly/megahit) assembles DNA sequences from mixed sources into contigs (contiguous stretches of DNA); compatibile with ancient DNA
- [metaSpades](http://bioinf.spbau.ru/en/spades3.7) assembles DNA sequences from mixed sources into contigs

**Ancient DNA damage**
- [mapDamage2](https://ginolhac.github.io/mapDamage/) tracks and quantifies DNA damage patterns
- [DamageProfiler](https://github.com/Integrative-Transcriptomics/DamageProfiler) used to calculate damage profiles of mapped ancient DNA reads
- [PyDamage](https://github.com/maxibor/pydamage) software to automate the process of contig damage identification and estimation 
- [PMD Tools](https://github.com/pontussk/PMDtools) computes ancient DNA damage patterns, and implements a likelihood framework incorporating postmortem damage (PMD), base quality scores and biological polymorphism to identify degraded DNA sequences that are unlikely to originate from modern contamination

**Variant calling and genotyping**
- [ANGSD](https://github.com/ANGSD/angsd) (Analysis of Next Generation Sequencing Data) is a multipurpose genetic data analysis tool that can be used for genotyping. 
- [GATK](https://software.broadinstitute.org/gatk/) is a software toolkit used to perform variant calling and genotyping. It can be used to estimate genotype likelihoods for phenotype-associated SNPs from ancient individuals
- [pileupCaller](https://github.com/stschiff/sequenceTools) is a tool used to sample alleles from low coverage data

**Sex, kinship, and contamination**
- [ry_compute](https://github.com/pontussk/ry_compute/blob/master/ry_compute.py) is a tool that estimates genetic sex from high-throughput DNA sequence data
- [lcMLkin](https://github.com/COMBINE-lab/maximum-likelihood-relatedness-estimation) (Maximum Likelihood Estimation of Relatedness) uses genotype likelihoods to infer genetic relatedness from low coverage sequencing data 
- [READ](https://bitbucket.org/tguenther/read) (Relationship Estimation from Ancient DNA) estimates genetic kinship between a pair of individuals represented by low coverage sequencing data 
- [ANGSD](https://github.com/ANGSD/angsd) (Analysis of Next Generation Sequencing Data) is a multipurpose genetic data analysis tool; its contamination module can be used to estimate nuclear contamination in males
- [Schmutzi](https://github.com/grenaud/schmutzi) performs mitochondrial consensus calling and estimates mitochondrial contamination for ancient DNA
- [SourceTracker2](https://github.com/biota/sourcetracker2) estimates source contributions to a metagenomic sample and can be used to identify environmental contaminants in mixed microbial communities, such as dental calculus and paleofeces 
- [SourcePredict](https://github.com/maxibor/sourcepredict) classifies and predicts the origin of metagenomic samples given a reference dataset of known origins using machine learning classification on dimensionally reduced datasets
- [Decontam](https://benjjneb.github.io/decontam/vignettes/decontam_intro.html) identifes contaminant sequences in a sample based on sequences identified in blanks and controls
- [AuthentiCT](https://github.com/StephanePeyregne/AuthentiCT) Provides an estimate of proportion of present-day DNA contamination in ancient DNA datasets using deamination patterns.
-[KIN](https://github.com/DivyaratanPopli/Kinship_Inference): Estimates genetic relatedness from ancient DNA data along with locations of IBD sharing and long runs of homozygosity

**Ancestry and admixture**
- [ADMIXTURE](http://www.genetics.ucla.edu/software/admixture/) estimates individual ancestries from SNP datasets  
- [Haplogrep2](http://haplogrep.uibk.ac.at) classifies mitochondrial haplogroups using SNP datasets 
- [Haplofind](https://haplofind.unibo.it) assigns mitochondrial haplogroups using DNA sequence data
- [yHaplo](https://github.com/23andMe/yhaplo) estimates the Y-haplogroup of males from SNP datasets
- [smartPCA](https://github.com/chrchang/eigensoft/blob/master/POPGEN/README) is a program within the EIGENSOFT software package that can be used to perform principal components analysis (PCA) on genetic data from ancient populations
- [AdmixTools](https://github.com/DReichLab/AdmixTools/blob/master/README.QpWave) is a toolkit for infering admixture. It is used to calculate f3-, f4-, and D-statistics, and it includes the programs qpGraph, qpAdm, qp3pop, and qp3Dstat- 
- [TreeMix](https://bitbucket.org/nygcresearch/treemix/wiki/Home) is used to infer patterns of population splits and mixtures in the history of a set of populations 

**Epigenetics**
- [epiPaleomix](https://bitbucket.org/khanghoj/epipaleomix) is a pipeline for generating nucleosome and methylation maps from ancient genomic data

**Population and evolutionary history**
- [BEAST2](http://www.beast2.org) is a Bayesian phylogenetic analysis software package used to date population divergence between samples of known ages, and it is also used to model changes in effective population sizes through time 
- [MEGA](https://www.megasoftware.net/) is a multi-function software suite for analyzing sequence data, including phylogenetic tree-building 
- [RevBayes](https://revbayes.github.io) is a modeling, simulation and Bayesian inference software for phylogenetic analysis 
- [SimCoal2](http://cmpg.unibe.ch/software/simcoal2/) is a coalescent modeling program for simulating recombination patterns under different demographic models, including migration events
- [Bayesian Serial SimCoal](http://web.stanford.edu/group/hadlylab/ssc/) (BayeSSC) is a modification of SimCoal that allows flexible coalescent modelling from different priors; it can incorporate ancient datasets to estimate the timing and magnitude of past demographic events
- [PSMC](https://github.com/lh3/psmc) (Pairwise Sequentially Markovian Coalescent) infers population size history from a diploid genome
- [MSMC](https://github.com/stschiff/msmc) (Multiple Sequentially Markovian Coalescent) infers population size history and gene flow from multiple genomes
- [RAxML](https://sco.h-its.org/exelixis/software.html)  (Randomized Axelerated Maximum Likelihood) infers phylogeny for large datasets using maximum likelihood
- [GenErode](https://github.com/NBISweden/GenErode) a bioinformatics pipeline for investigating genome erosion in endangered and extinct species

**Species identification and metagenomics**
- [BLAST](https://blast.ncbi.nlm.nih.gov/Blast.cgi)  (Basic Local Alignment Tool) identifies regions of similarity between a query sequence and reference database
- [DIAMOND](http://ab.inf.uni-tuebingen.de/software/diamond/) is an ultrafast DNA aligner that aligns translated DNA sequences to a protein sequence database
- [MALT](http://ab.inf.uni-tuebingen.de/software/malt/) (MEGAN ALignment Tool) rapidly aligns DNA sequences to a reference database. It is especially useful for large metagenomic datasets
- [MEGAN](http://ab.inf.uni-tuebingen.de/software/megan6/) is a multi-function software suite for analyzing metagenomic data
- [sam2lca](https://github.com/maxibor/sam2lca) is a program performing reference sequence disambiguation for reads mapping to multiple reference sequences in a shotgun metagenomics sequencing dataset; it takes as input the common SAM sequence alignment format and applies the lowest common ancestor algorithm
- [metaPhlAn3](https://huttenhower.sph.harvard.edu/metaphlan/) uses marker genes from reference genomes to profile microbial communities in metagenomic data
- [Kraken2](https://github.com/DerrickWood/kraken2) is a taxonomic sequence classifier that assigns taxonomic labels to short DNA reads by examining the k-mers within a read and querying a database with those k-mers
- [KrakenUniq](https://github.com/fbreitwieser/krakenuniq) is a metagenomics classifier that combines the fast k-mer-based classification of Kraken with an efficient algorithm for assessing the coverage of unique k-mers found in each species in a dataset
- [SPARSE](https://github.com/zheminzhou/SPARSE) is a tool for identifying pathogen sequences in ancient metagenomics data sets
- [metaBIT](https://bitbucket.org/Glouvel/metabit) is a taxonomic profiling and visualization software for metagenomics data sets

**Visualization tools**
- [IGV](https://software.broadinstitute.org/software/igv/) (Integrative Genomics Viewer) is a high-performance interactive tool for the visual exploration of genomic data
- [Krona](https://github.com/marbl/Krona/wiki) is a visualization tool that allows hierarchical data to be explored through interactive, mulit-layered pie charts.It is especially useful for visualizing taxonomically assigned metagenomics data
- [GrapeTree](https://github.com/achtman-lab/GrapeTree) is an interactive tree visualization program that supports manipulation of tree layout and metadata

### Ancient Proteins

- [MASCOT](https://www.matrixscience.com/) is a search engine for the identification, characterisation and quantitation of proteins using mass spectrometry data
- [Max Quant](https://www.maxquant.org/) is a quantitative proteomics software package designed for analyzing large mass-spectrometric data sets
- [PEAKS](https://www.thermofisher.com/order/catalog/product/PEAKS40) is a proteomics software program for tandem mass spectrometry designed for peptide sequencing, protein identification and quantification
- [Byonic](https://proteinmetrics.com/byos/) is a MS/MS search engine
- [mMass](http://www.mmass.org/) is open-source software primarily used for analyzing MALDI-TOF data in ZooMS analysis

### Stable Isotopes

- [simmer](https://cran.r-project.org/web/packages/simmr/vignettes/simmr.html) is an R package designed to solve mixing equations for stable isotopic data within a Bayesian framework 
- [FRUITS](https://sourceforge.net/projects/fruits/) is a Bayesian mixing model for diet reconstruction using isotopic data
