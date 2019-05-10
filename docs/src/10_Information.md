```@meta
EditURL = "https://github.com/TRAVIS_REPO_SLUG/blob/master/"
```

# Counting residues

[![](https://mybinder.org/badge_logo.svg)](https://mybinder.org/v2/gh/TRAVIS_REPO_SLUG/gh-pages?filepath=TRAVIS_TAG/notebooks/10_Information.ipynb)
[![](https://img.shields.io/badge/show-nbviewer-579ACA.svg)](https://nbviewer.jupyter.org/github/TRAVIS_REPO_SLUG/blob/gh-pages/TRAVIS_TAG/notebooks/10_Information.ipynb)

MIToS was designed to perform fast counting of residues. To achieve that,
each `Residue` is encoded as an integer that can be used to index.

```@example 10_Information
using MIToS.MSA
res = Residue('C')
```

```@example 10_Information
Int(res)
```

Let's count residues in the *UBA domain* Pfam family.

```@example 10_Information
using MIToS.Pfam
const msa_file = downloadpfam("PF16577")
```

```@example 10_Information
const msa = read(msa_file, Stockholm)
```

We can access the MSA as a matrix to get a particular column or sequence:
```julia
msa[:, column]
msa[sequence, :]
```

```@example 10_Information
col_i = msa[:, 10]
```

MIToS Information module has functions to get residue frequencies (counts or
fractions) and to return contingency tables:

```@example 10_Information
using MIToS.Information
```

```@example 10_Information
Ni = count(col_i)
```

```@example 10_Information
Pi = probabilities(col_i)
```

`Counts` and `Probabilities` objects wrap a `ContingencyTable`:

```@example 10_Information
Pi.table
```

They can be quickly indexed by using `Residue`s:

```@example 10_Information
Pi[Residue('P')]
```

You can create a bidimensional `ContingencyTable` by using two MSA columns or
sequences (there is no limit to the number of dimensions):

```@example 10_Information
col_j = msa[:, 15]

Nij = count(col_i, col_j)
```

```@example 10_Information
Nij[Residue('P'), Residue('R')]
```

You can also get probabilities by normalizing counts:

```@example 10_Information
Pij = normalize(Nij.table)
```

```@example 10_Information
Pij[Residue('P'), Residue('R')]
```

## Plotting counts

We use a `heatmap` to plot a bidimensional table:

```@example 10_Information
using Plots
gr()
```

We can list the available color libraries:

```@example 10_Information
clibraries()
```

Visualize the color maps defined in a library:

```@example 10_Information
showlibrary(:Plots)
```

And select the color library we want to use:

```@example 10_Information
clibrary(:cmocean)
```

For this plot, we use the interactive *Plotly* backend

```@example 10_Information
plotlyjs()
```

We need a vector of strings for the ticks labels...

```@example 10_Information
x = string.(Residue.(UngappedAlphabet()))
```

...because `xticks` and `xticks` keyword arguments take a tuple:
`(positions, labels)`

```@example 10_Information
heatmap(Nij,
		color=:tempo,
		ratio=:equal,
		xticks=(1:length(x), x),
		yticks=(1:length(x), x))
```

## Functions taking counts and probabilities

Information defines different functions that take contingency tables as an
input, for example:

```@example 10_Information
entropy(Ni)
```

```@example 10_Information
mutual_information(Nij)
```

### Conservation

You can use the MIToS' Information module to calculate the Shannon entropy of
each MSA column:

```@example 10_Information
using MIToS.Information

const alphabet = UngappedAlphabet()
```

You also have `GappedAlphabet` and `ReducedAlphabet`:

```@example 10_Information
ReducedAlphabet("(AILMV)(RHK)(NQST)(DE)(FWY)CGP")
```

Empty contingency tables can be defined by using
`ContingencyTable(element_type, Val{dimensions}, alphabet)`:

```@example 10_Information
const table = ContingencyTable(Int, Val{1}, alphabet)
```

The `mapcolfreq!`, `mapseqfreq!`, `mapcolpairfreq!` and `mapseqpairfreq!`
functions from the Information module apply a function on the table filled
using each column, sequence, column pair or sequence pair of the MSA,
respectively:

```@example 10_Information
Hx = mapcolfreq!(entropy, msa, Counts(table))
```

We use **Plots.jl** to visualize the entropy of each column to find variable
and conserved regions

```@example 10_Information
gr()
```

```@example 10_Information
plot_entropy = plot(vec(Hx),
					color=:orange,
					fill=0,
					fillalpha=0.5,
					legend=false,
					ylab="Entropy")
```

```@example 10_Information
plot_msa = plot(msa, legend=false)
```

```@example 10_Information
plot(plot_entropy,
	 plot_msa,
	 layout=grid(2, 1, heights=[0.2, 0.8]),
	 link=:x)
```

## Multivariate mutual information

We are going to measure mutual information in MSA column triplets. We use
Julia parallelism because the number of combinations is high.

```@example 10_Information
using Distributed
```

```@example 10_Information
nprocs()
```

```@example 10_Information
addprocs(3)
```

```@example 10_Information
nprocs()
```

We are going to use [Combinatorics](https://github.com/JuliaMath/Combinatorics.jl)
everywhere (in all the process) to get a generator of the combinations and
[ProgressMeter](https://github.com/timholy/ProgressMeter.jl) to see the
progress of the parallel loop.

```@example 10_Information
@everywhere using Combinatorics
@everywhere using ProgressMeter
@everywhere using MIToS.MSA
@everywhere using MIToS.Information
```

#### Exercise 1

Fill the missing parts of the function to calculate mutual information
between MSA columns i, j and k.

```@example 10_Information
function parallel_mmi(msa)
	ncols = ncolumns(msa)
	triplets = combinations(1:ncols, 3)
	@showprogress pmap(triplets) do (i, j, k)
#           ...to complete...
#           (i, j, k) => ...to complete...
	end
end
```

```@example 10_Information
mi_values = parallel_mmi(msa)
```

*This page was generated using [Literate.jl](https://github.com/fredrikekre/Literate.jl).*

