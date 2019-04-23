# # Statistics
#
#md # [![](https://mybinder.org/badge_logo.svg)](@__BINDER_ROOT_URL__notebooks/Introduction/04_DataStructures.ipynb)
#md # [![](https://img.shields.io/badge/show-nbviewer-579ACA.svg)](@__NBVIEWER_ROOT_URL__notebooks/Introduction/04_DataStructures.ipynb)
#
# ## Missing values
#
# Julia, like R, has a value to represent
# [missing values](https://docs.julialang.org/en/v1/manual/missing/index.html):

data = [ 1.0, 2.0, missing, 4.0 ]

# This value implements three-valued logic:

false & missing

#-

true & missing

# You can use `ismissing` or `skipmissing` when necessary:

sum(data)

#-

ismissing.(data)

#-

sum(data[.!(ismissing.(data))])

#-

sum(skipmissing(data))

# ## DataFrames
#
# It is very useful to work with tabular data. One of the most simplest Julia
# packages for that is [DataFrames](http://juliadata.github.io/DataFrames.jl/stable/).

using DataFrames

# To read this kind of files, you can use the
# [CSV package](https://juliadata.github.io/CSV.jl/stable/).

using CSV

# For example, the `pdb_chain_taxonomy.tsv.gz` file that has a summary of the
# NCBI tax_id(s), scientific_name(s) and chain type for each PDB chain that
# has been processed in the SIFTS database. This table should be downloaded
# from the [SIFTS site](https://www.ebi.ac.uk/pdbe/docs/sifts/quick.html).
#
#```julia
#table_path = download(
#    "ftp://ftp.ebi.ac.uk/pub/databases/msd/sifts/flatfiles/tsv/pdb_chain_taxonomy.tsv.gz",
#    "pdb_chain_taxonomy.tsv.gz")
#
#run(`gunzip $table_path`)
#```
#
# If that fails, you can use the first lines stored in the data folder:
# ```julia
# using  JuliaForBioinformatics
# data_path = abspath(pathof(JuliaForBioinformatics), "..", "..", "data")
# table_path = joinpath(data_path, "pdb_chain_taxonomy_head.tsv")
#```

df = CSV.read("pdb_chain_taxonomy.tsv",
    header = 2,  ## the header is in the second line
    delim = '\t',  ## delimiter is TAB instead of ','
    quotechar='`'  ## file don't use "" to quote, e.g.: "Bacillus coli" Migula 1895
    )

# ### Examples
#
# Select human PDB chains:

df[:TAX_ID] .== 9606

#-

df[df[:TAX_ID] .== 9606, [:PDB, :CHAIN]] |> unique

# You can use `|>` for easy function chaining.
#
# What are the species with more PDB chains?

count_df = by(df, :TAX_ID, Count = :TAX_ID => length)
sort!(count_df, :Count, rev=true)

# Exercice 1
#
# What are the species with more PDBs (not PDB chains)?
#
# **Hint:** You can use
# [anonymous functions](https://docs.julialang.org/en/v1/manual/functions/index.html#man-anonymous-functions-1):

f(x) = 2x + 1
g(x) = sin(π*x)

#-

x -> f(g(x))

# or function composition (using `∘`, `\circ<TAB>`):

f ∘ g

#-

## ...your solution...
