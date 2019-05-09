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

# -

const msa = read(msa_file, Stockholm)

#-

col_i = msa[:, 10]

#-

using MIToS.Information

#-

Ni = count(col_i)

#-

Pi = probabilities(col_i)

#-

Pi.table

#-

Pi[Residue('P')]

#-

col_j = msa[:, 15]

Nij = count(col_i, col_j)

#-

Nij[Residue('P'), Residue('R')]

#-

Pij = normalize(Nij.table)

#-

Pij[Residue('P'), Residue('R')]

#-

using Plots
plotlyjs()

#-

x = string.(Residue.(UngappedAlphabet()))

#-

clibraries()

#-

showlibrary(:Plots)

#-

clibrary(:cmocean)

#-

heatmap(x, x, Nij, color=:tempo)

#-

entropy(Ni)

#-

mutual_information(Nij)

# ### Conservation
#
# You can use the MIToS' Information module to calculate the Shannon entropy of
# each MSA column:

using MIToS.Information

Hx = mapcolfreq!(entropy, # function to apply over the contingne
	msa,
	Counts(
		ContingencyTable(Float64,
			Val{1},
			UngappedAlphabet())))
