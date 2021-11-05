

Modified-bcalm for directed unitigs
=====

This tool computes directed and double directed unitigs from a FASTA/FASTQ file.



Note : This uses a modified version of bcalm in [https://github.com/Malfoy/BCALM](https://github.com/Malfoy/BCALM)

## Pre-requisites
=====
Require [Jellyfish](https://github.com/gmarcais/Jellyfish) to be installed. 

## Installation
=====
`make`


## Usage
=====

Usage: `./dd_unitigs.sh <fasta> <k>`

### To compute double directed unitigs:

`./dd_unitigs.sh example/ref.fa 31`   
Output: File named uni_dd.fa containing double directed unitigs.

### To compute basic directed unitigs:

`./directed_unitigs.sh example/ref.fa 31`   
Output: File named uni_directed.fa containing basic directed unitigs.

## License
=======

BCALM's license is BSD with Attribution. In informal words, any use is permitted as long as it acknowledges us. For example with a citation to:

    @inproceedings{reprdbg14,
    author = {Chikhi, R. and Limasset, A. and Jackman, S. and Simpson, J. and Medvedev, P.},
    title = {{On the representation of de Bruijn graphs}},
    booktitle = {RECOMB},
    publisher = {Springer},
    year = 2014,
    }

