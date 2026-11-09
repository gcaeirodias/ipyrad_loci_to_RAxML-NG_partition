#!/bin/bash

# Change working directory to the folder containing the ipyrad output file .loci.
cd ipyrad/output/file.loci

# Convert the file containing the filtered loci outputed from ipyrad (.loci) to a file containing the DNA partition (.phylip) needed to run RAxML-NG with multiple partitions.
# Substitute 'file.loci' with the name of the file outputed by ipyrad and the 'file_partition.phylip' with the name that you want for your partition file.
sed -n 'N; /^.*\n\/\//P; D' file.loci | \
awk '{print length($2)}' | \
awk '{ sum += $1; print $0, sum }' | \
awk '{ print $0, ($2 + 1) }' | \
awk '{ print "DNA,","p"NR"="$3-$1"-"$2}' > file_partition.phylip
