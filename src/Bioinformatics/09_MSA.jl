# # Multiple Sequence Alignments
#
#md # [![](https://mybinder.org/badge_logo.svg)](@__BINDER_ROOT_URL__notebooks/09_MSA.ipynb)
#md # [![](https://img.shields.io/badge/show-nbviewer-579ACA.svg)](@__NBVIEWER_ROOT_URL__notebooks/09_MSA.ipynb)
#
# For this example, we use the Multiple Sequence Alignment (MSA) of the
# catalytic domain from the *Cytosol aminopeptidase family*. We use the
# `downloadpfam` function of the MIToS' Pfam module to get the annotated
# [Stockholm](https://en.wikipedia.org/wiki/Stockholm_format) file from the
# [Pfam](pfam.xfam.org/) database:

using MIToS.Pfam
const pfam_file = downloadpfam("PF00883")

# The `read` function from MIToS' MSA allows parsing multiple sequence
# alignments. The file format is indicated by the second argument. There is
# no need for decompressing the file before reading it:

using MIToS.MSA
msa = read(pfam_file, Stockholm)

# Pfam alignments are generated using [HMMER3](http://hmmer.org/) Hidden Markov
# Model (HMM) searches, have insertion columns (indicated by dots and lowercase
# letters):

first_seq = sequencenames(msa)[1]

# **TIP:** You can use [TranscodingStreams](https://bicycle1885.github.io/TranscodingStreams.jl/stable/)
# to read compressed files. In particular, the *CodecZlib* package has the
# needed codecs for reading gzipped files.
# For example, the next cell is similar to using `zgrep` in Linux:
# ```bash
# zgrep ^A0A094YQ53_BACAO/182-489 PF00883.stockholm.gz
# ```

using CodecZlib

open(GzipDecompressorStream, pfam_file) do file
	for line in eachline(file)
		if startswith(line, first_seq)
			println(line)
		end
	end
end

# **TIP:** If you are on Linux and you have zgrep installed, you can run it as an
# [external command](https://docs.julialang.org/en/v1/manual/running-external-programs/index.html)
# and use interpolation:
# ```julia
# run(`zgrep ^$first_seq $pfam_file`)
# ```
# or using the [shell mode](https://docs.julialang.org/en/v1/stdlib/REPL/#The-different-prompt-modes-1)
# of the Julia REPL:
# ```julia
# ;zgrep ^$first_seq $pfam_file
# ```
#
# Insert columns are deleted by MIToS, therefore the first MSA column has the
# label `"69"` (column  number in the input file) instead of `"1"`:

columnnames(msa)[1]

# If we want to keep track of residue numbers in each sequence, we need to read
# the file using the keyword arguments `generatemapping` and `useidcoordinates`:

const mapped_msa = read(pfam_file,
						Stockholm,
						generatemapping=true,
						useidcoordinates=true)

#-

getsequencemapping(mapped_msa, "A0A094YQ53_BACAO/182-489")

# The mapping is stored in the MSA annotations and it is automatically updated
# when columns are deleted.
#
# The `getannot...` functions return dictionaries with the MSA annotations

getannotresidue(mapped_msa)

# Pfam has "AS" (active site) and "pAS" (predicted active site) annotations for
# some families. We use `filter` to get a dictionary with the experimentally
# annotated active site residues (indicated by `*`):

active_sites = filter(pair -> pair[1][2] == "AS", getannotresidue(mapped_msa))

# #### Exercise I
#
# Which are the UniProt residue numbers of residues at the active site of
# AMPL_BOVIN/197-508?
#
# **Hint:** You can use the functions `getsequencemapping` and `zip`.
#

## ...your solution...

#src for (pos, ann) in zip(getsequencemapping(mapped_msa, "AMPL_BOVIN/197-508"),
#src 			 		   active_sites[("AMPL_BOVIN/197-508", "AS")])
#src 	if ann == '*'
#src 		println(pos)
#src 	end
#src end

# The answer is [294 and 368](https://www.uniprot.org/uniprot/P00727).

# ## MSA statistics and plotting
#
# [Plots.jl](http://docs.juliaplots.org/latest/) is a nice library because
# it gives a single API for multiple plotting backends (packages):
# - [GR](https://github.com/jheinen/GR.jl) is fast
# - [PlotlyJS](https://github.com/sglyon/PlotlyJS.jl) is interactive
# - [UnicodePlots](https://github.com/Evizero/UnicodePlots.jl) doesn't need a graphics environment
# - [PGFPlots](https://github.com/JuliaTeX/PGFPlots.jl) has LaTeX quality
# - [PyPlot](https://github.com/JuliaPy/PyPlot.jl) for pythonists

using Plots
gr() # choose the plotting backend

# Plots.jl allows to define [plot recipes](docs.juliaplots.org/latest/recipes/)
# and MIToS uses them to define plots for common biological objects:

plot(mapped_msa)

# Plots are also really useful to visualize MSA statistics:

plotlyjs() # change to an interactive backend

#-

gap_percentage = 100.0 .* gapfraction(mapped_msa, 1) # i.e. reduce dimension 1

#-

x = names(gap_percentage, 2)

#-

y = vec(gap_percentage)

#-

plot(x, y, legend=false)
xlabel!("MSA column (input file)")
ylabel!("Gap percentage")

# Something you can easily calculate with MIToS is the percentage identity
# between all the sequences in a Multiple Sequence Alignment:

percent_id = percentidentity(mapped_msa)

# #### Exercise 1
#
# What is the sequence that has the highest identity percentage with
# AMPL_BOVIN/197-508?
#
# **Hint:** Use [NamedArrays](https://github.com/davidavdav/NamedArrays.jl)
# `Not` indexing and `names` and Julia's `findmax`:

using NamedArrays

## ...your solution...

#src identities = percent_id["AMPL_BOVIN/197-508", Not("AMPL_BOVIN/197-508")]
#src value, index = findmax(identities)
#src names(identities, 1)[index]
