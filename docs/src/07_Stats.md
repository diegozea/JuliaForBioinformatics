```@meta
EditURL = "https://github.com/TRAVIS_REPO_SLUG/blob/master/"
```

# Statistics

[![](https://mybinder.org/badge_logo.svg)](https://mybinder.org/v2/gh/TRAVIS_REPO_SLUG/gh-pages?filepath=TRAVIS_TAG/notebooks/07_Stats.ipynb)
[![](https://img.shields.io/badge/show-nbviewer-579ACA.svg)](https://nbviewer.jupyter.org/github/TRAVIS_REPO_SLUG/blob/gh-pages/TRAVIS_TAG/notebooks/07_Stats.ipynb)

## Missing values

Julia, like R, has a value to represent
[missing values](https://docs.julialang.org/en/v1/manual/missing/index.html):

```@example 07_Stats
data = [ 1.0, 2.0, missing, 4.0 ]
```

This value implements three-valued logic:

```@example 07_Stats
false & missing
```

```@example 07_Stats
true & missing
```

You can use `ismissing` or `skipmissing` when necessary:

```@example 07_Stats
sum(data)
```

```@example 07_Stats
ismissing.(data)
```

```@example 07_Stats
sum(data[.!(ismissing.(data))])
```

```@example 07_Stats
sum(skipmissing(data))
```

## DataFrames

It is very useful to work with tabular data. One of the most simplest Julia
packages for that is [DataFrames](http://juliadata.github.io/DataFrames.jl/stable/).

```@example 07_Stats
using DataFrames
```

To read this kind of files, you can use the
[CSV package](https://juliadata.github.io/CSV.jl/stable/).

```@example 07_Stats
using CSV
```

For example, the `pdb_chain_taxonomy.tsv.gz` file that has a summary of the
NCBI tax_id(s), scientific_name(s) and chain type for each PDB chain that
has been processed in the SIFTS database. This table should be downloaded
from the [SIFTS site](https://www.ebi.ac.uk/pdbe/docs/sifts/quick.html).

```julia
table_path = download(
    "ftp://ftp.ebi.ac.uk/pub/databases/msd/sifts/flatfiles/tsv/pdb_chain_taxonomy.tsv.gz",
    "pdb_chain_taxonomy.tsv.gz")

run(`gunzip $table_path`)
```

If that fails, you can use the first lines stored in the data folder:
```julia
using  JuliaForBioinformatics
data_path = abspath(pathof(JuliaForBioinformatics), "..", "..", "data")
table_path = joinpath(data_path, "pdb_chain_taxonomy_head.tsv")
```

```@example 07_Stats; continued = true
df = CSV.read("pdb_chain_taxonomy.tsv",
    header = 2,  ## the header is in the second line
    delim = '\t',  ## delimiter is TAB instead of ','
    quotechar='`'  ## file don't use "" to quote, e.g.: "Bacillus coli" Migula 1895
    )
```

### Examples

Select human PDB chains:

```@example 07_Stats
df[:TAX_ID] .== 9606
```

```@example 07_Stats
df[df[:TAX_ID] .== 9606, [:PDB, :CHAIN]] |> unique
```

You can use `|>` for easy function chaining.

What are the species with more PDB chains?

```@example 07_Stats
count_df = by(df, :TAX_ID, Count = :TAX_ID => length)
sort!(count_df, :Count, rev=true)
```

#### Exercice 1

What are the species with more PDBs (not PDB chains)?

**Hint:** You can use
[anonymous functions](https://docs.julialang.org/en/v1/manual/functions/index.html#man-anonymous-functions-1):

```@example 07_Stats
f(x) = 2x + 1
g(x) = sin(π*x)
```

```@example 07_Stats
x -> f(g(x))
```

or function composition (using `∘`, `\circ<TAB>`):

```@example 07_Stats
f ∘ g
```

```@example 07_Stats
# ...your solution...
```

*This page was generated using [Literate.jl](https://github.com/fredrikekre/Literate.jl).*
