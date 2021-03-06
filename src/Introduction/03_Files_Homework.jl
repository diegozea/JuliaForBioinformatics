# # HOMEWORK: Working with Files
#
#md # [![](https://mybinder.org/badge_logo.svg)](@__BINDER_ROOT_URL__notebooks/03_Files_Homework.ipynb)
#md # [![](https://img.shields.io/badge/show-nbviewer-579ACA.svg)](@__NBVIEWER_ROOT_URL__notebooks/03_Files_Homework.ipynb)
#
# Often, bioinformatic pipelines imply to manipulate text files. Here, we are
# going to parse a very simple FASTA file just as an example.
#
# There is a FASTA file in the data folder of this repo:

using  JuliaForBioinformatics
repo_path = pathof(JuliaForBioinformatics)

# You can use `joinpath` and `abspath` to construct a path that works in all
# the operative systems:

data_path = abspath(repo_path, "..", "..", "data")

#-

fasta_file = joinpath(data_path, "O43521.fasta")

# You can use `open` with the
# [`do` syntax](https://docs.julialang.org/en/v1/manual/functions/#Do-Block-Syntax-for-Function-Arguments-1)
# to read or write a file in Julia:

open(fasta_file, "r") do file
    for line in eachline(file)
        println(line)
    end
end

# #### Homework
#
# Write a function to read the FASTA file into a dictionary from the
# sequence/isoform UniProt name, i.e. the one between `|`, to the sequence.
#
# **Hint!** You can use the following functions:

split("1 2 3", ' ')

#-

startswith("Hello world!", 'H')

#-

strip("  Hello world!  ")

# and [string concatenation](https://docs.julialang.org/en/v1/manual/strings/#man-concatenation-1):

"Hello " * "world!"

#-

## function read_fasta(...)
##     ...
## end
