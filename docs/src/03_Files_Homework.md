```@meta
EditURL = "https://github.com/TRAVIS_REPO_SLUG/blob/master/"
```

# HOMEWORK: Working with Files

[![](https://mybinder.org/badge_logo.svg)](https://mybinder.org/v2/gh/TRAVIS_REPO_SLUG/gh-pages?filepath=TRAVIS_TAG/notebooks/03_Files_Homework.ipynb)
[![](https://img.shields.io/badge/show-nbviewer-579ACA.svg)](https://nbviewer.jupyter.org/github/TRAVIS_REPO_SLUG/blob/gh-pages/TRAVIS_TAG/notebooks/03_Files_Homework.ipynb)

Often, bioinformatic pipelines imply to manipulate text files. Here, we are
going to parse a very simple FASTA file just as an example.

There is a FASTA file in the data folder of this repo:

```@example 03_Files_Homework
using  JuliaForBioinformatics
repo_path = pathof(JuliaForBioinformatics)
```

You can use `joinpath` and `abspath` to construct a path that works in all
the operative systems:

```@example 03_Files_Homework
data_path = abspath(repo_path, "..", "..", "data")
```

```@example 03_Files_Homework
fasta_file = joinpath(data_path, "O43521.fasta")
```

You can use `open` with the
[`do` syntax](https://docs.julialang.org/en/v1/manual/functions/#Do-Block-Syntax-for-Function-Arguments-1)
to read or write a file in Julia:

```@example 03_Files_Homework
open(fasta_file, "r") do file
    for line in eachline(file)
        println(line)
    end
end
```

#### Homework

Write a function to read the FASTA file into a dictionary from the
sequence/isoform UniProt name, i.e. the one between `|`, to the sequence.

**Hint!** You can use the following functions:

```@example 03_Files_Homework
split("1 2 3", ' ')
```

```@example 03_Files_Homework
startswith("Hello world!", 'H')
```

```@example 03_Files_Homework
strip("  Hello world!  ")
```

and [string concatenation](https://docs.julialang.org/en/v1/manual/strings/#man-concatenation-1):

```@example 03_Files_Homework
"Hello " * "world!"
```

```@example 03_Files_Homework
# function read_fasta(...)
#     ...
# end
```

*This page was generated using [Literate.jl](https://github.com/fredrikekre/Literate.jl).*

