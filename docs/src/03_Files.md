```@meta
EditURL = "https://github.com/TRAVIS_REPO_SLUG/blob/master/"
```

# Working with Files

Often, bioinformatic pipelines imply to manipulate text files. Here, we are
going to parse a very simple FASTA file just as an example.

There is a FASTA file in the data folder of this repo:

```@example 03_Files
using  JuliaForBioinformatics
repo_path = pathof(JuliaForBioinformatics)
```

You can use `joinpath` and `abspath` to construct a path that works in all
the operative systems:

```@example 03_Files
data_path = abspath(repo_path, "..", "..", "data")
```

```@example 03_Files
fasta_file = joinpath(data_path, "O43521.fasta")
```

You can use `open` with the
[`do` syntax](https://docs.julialang.org/en/v1/manual/functions/#Do-Block-Syntax-for-Function-Arguments-1)
to read or write a file in Julia:

```@example 03_Files
open(fasta_file, "r") do file
    for line in eachline(file)
        println(line)
    end
end
```

#### Exercise 1

Write a function to read the FASTA file into a dictionary from the
sequence/isoform UniProt name, i.e. the one between `|`, to the sequence.

**Hint!** You can use the following functions:

```@example 03_Files
split("1 2 3", ' ')
```

```@example 03_Files
startswith("Hello world!", 'H')
```

```@example 03_Files
strip("  Hello world!  ")
```

and [string concatenation](https://docs.julialang.org/en/v1/manual/strings/#man-concatenation-1):

```@example 03_Files
"Hello " * "world!"
```

```@example 03_Files
# function read_fasta(...)
#     ...
# end
```

## Regex

You can also use [regular expressions](https://docs.julialang.org/en/v1/manual/strings/#Regular-Expressions-1).
They are very useful to parse text files.

```@example 03_Files
line = ">sp|O43521|B2L11_HUMAN Bcl-2-like protein 11 OS=Homo sapiens OX=9606 GN=BCL2L11 PE=1 SV=1"
```

```@example 03_Files
regex = r"^>\w+\|(\w+)\|"
```

```@example 03_Files
m = match(regex, line)
```

```@example 03_Files
if m !== nothing
    println(m[1])
end
```

## String interpolation

You can [interpolate values](https://docs.julialang.org/en/v1/manual/strings/#string-interpolation-1),
single variables or the result of more complex expressions, into
strings using `$`:

```@example 03_Files
a = 1
b = 2
"$a + $b is $(a + b)"
```

*This page was generated using [Literate.jl](https://github.com/fredrikekre/Literate.jl).*

