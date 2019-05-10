# # Counting residues
#
# MIToS was designed to perform fast counting of residues. To achieve that,
# each `Residue` is encoded as an integer that can be used to index.
#

using MIToS.MSA
res = Residue('C')

#-

Int(res)

# Let's count residues in the *UBA domain* Pfam family.

using MIToS.Pfam
const msa_file = downloadpfam("PF16577")

#-

const msa = read(msa_file, Stockholm)

# We can access the MSA as a matrix to get a particular column or sequence:
# ```julia
# msa[:, column]
# msa[sequence, :]
# ```

col_i = msa[:, 10]

# MIToS Information module has functions to get residue frequencies (counts or
# fractions) and to return contingency tables:

using MIToS.Information

#-

Ni = count(col_i)

#-

Pi = probabilities(col_i)

# `Counts` and `Probabilities` objects wrap a `ContingencyTable`:

Pi.table

# They can be quickly indexed by using `Residue`s:

Pi[Residue('P')]

# You can create a bidimensional `ContingencyTable` by using two MSA columns or
# sequences (there is no limit to the number of dimensions):

col_j = msa[:, 15]

Nij = count(col_i, col_j)

#-

Nij[Residue('P'), Residue('R')]

# You can also get probabilities by normalizing counts:

Pij = normalize(Nij.table)

#-

Pij[Residue('P'), Residue('R')]

# ## Plotting counts
#
# We use a `heatmap` to plot a bidimensional table:
#

using Plots
gr()

# We can list the available color libraries:

clibraries()

# Visualize the color maps defined in a library:

showlibrary(:Plots)

# And select the color library we want to use:

clibrary(:cmocean)


# For this plot, we use the interactive *Plotly* backend

plotlyjs()

# We need a vector of strings for the ticks labels...

x = string.(Residue.(UngappedAlphabet()))

# ...because `xticks` and `xticks` keyword arguments take a tuple:
# `(positions, labels)`

heatmap(Nij,
		color=:tempo,
		ratio=:equal,
		xticks=(1:length(x), x),
		yticks=(1:length(x), x))

# ## Functions taking counts and probabilities
#
# Information defines different functions that take contingency tables as an
# input, for example:

entropy(Ni)

#-

mutual_information(Nij)

# ### Conservation
#
# You can use the MIToS' Information module to calculate the Shannon entropy of
# each MSA column:

using MIToS.Information

const alphabet = UngappedAlphabet()

# You also have `GappedAlphabet` and `ReducedAlphabet`:

ReducedAlphabet("(AILMV)(RHK)(NQST)(DE)(FWY)CGP")

# Empty contingency tables can be defined by using
# `ContingencyTable(element_type, Val{dimensions}, alphabet)`:

const table = ContingencyTable(Int, Val{1}, alphabet)

# The `mapcolfreq!`, `mapseqfreq!`, `mapcolpairfreq!` and `mapseqpairfreq!`
# functions from the Information module apply a function on the table filled
# using each column, sequence, column pair or sequence pair of the MSA,
# respectively:

Hx = mapcolfreq!(entropy, msa, Counts(table))

# We use **Plots.jl** to visualize the entropy of each column to find variable
# and conserved regions

gr()

#-

plot_entropy = plot(vec(Hx),
					color=:orange,
					fill=0,
					fillalpha=0.5,
					legend=false,
					ylab="Entropy")

#-

plot_msa = plot(msa, legend=false)

#-

plot(plot_entropy,
	 plot_msa,
	 layout=grid(2, 1, heights=[0.2, 0.8]),
	 link=:x)

# ## Multivariate mutual information
#
# We are going to measure mutual information in MSA column triplets. We use
# Julia parallelism because the number of combinations is high.
#

using Distributed

#-

nprocs()

#-

addprocs(3)

#-

nprocs()

# We are going to use [Combinatorics](https://github.com/JuliaMath/Combinatorics.jl)
# everywhere (in all the process) to get a generator of the combinations and
# [ProgressMeter](https://github.com/timholy/ProgressMeter.jl) to see the
# progress of the parallel loop.

@everywhere using Combinatorics
@everywhere using ProgressMeter
@everywhere using MIToS.MSA
@everywhere using MIToS.Information

# #### Exercise 1
#
# Fill the missing parts of the function to calculate mutual information
# between MSA columns i, j and k.

function parallel_mmi(msa)
	ncols = ncolumns(msa)
	triplets = combinations(1:ncols, 3)
	@showprogress pmap(triplets) do (i, j, k)
##           ...to complete...
##           (i, j, k) => ...to complete...
#src		table = probabilities(msa[:, i], msa[:, j], msa[:, k])
#src		(i, j, k) => mutual_information(table)
	end
end

#-

mi_values = parallel_mmi(msa)
