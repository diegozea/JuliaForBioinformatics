# # MSA and structures
#
#md # [![](https://mybinder.org/badge_logo.svg)](@__BINDER_ROOT_URL__notebooks/11_PDB.ipynb)
#md # [![](https://img.shields.io/badge/show-nbviewer-579ACA.svg)](@__NBVIEWER_ROOT_URL__notebooks/11_PDB.ipynb)
#
# For this example, we use the Multiple Sequence Alignment (MSA) of the
# *Mu DNA-binding domain*.

using MIToS.Pfam
using MIToS.MSA

const pfam_file = downloadpfam("PF02316")
const msa = read(pfam_file,
				 Stockholm,
				 generatemapping=true,
				 useidcoordinates=true)

# We use the `getseq2pdb` function to look into the Pfam annotations for PDBs:

const seq2pdb = getseq2pdb(msa)

# For this example, we use the crystallographic structure 4FCY...

selected = [ (seq, pdb, chain) for (seq, pdbs) in seq2pdb
				for (pdb, chain) in pdbs if pdb == "4FCY" ]

# ...and we take the first one

seq_id, pdb_id, chain = selected[1]

# We download and read the PDB file

using MIToS.PDB
pdb_file = downloadpdb(pdb_id, format=PDBFile)

#-

const pdb_res = read(pdb_file, PDBFile)

# Each PDBResidue contains the information in the ATOM and HETATM PDB lines:

first_residue = pdb_res[1]

# You can access the information by accessing the field names:

first_residue.id.name

# #### Exercise 1
# 4
#
# How many missing residues are in the chain A

# How many chains are in the PDB?
#
# **Hint:** You can use `Set` or `unique`

#src chains = Set([ res.id.chain for res in pdb_res ])
#src length(chains)

# There are 5 chains: A, B, C, D, E

# ## Distances and contacts
#
# MIToS PDB module has functions to measure distance between residues and
# identify contacts:
#

res_i = pdb_res[1]
res_j = pdb_res[4]
distance(res_i, res_j)

# `contact(i, j, threshold)` is faster than `distance(i, j) < threshold`

contact(res_i, res_j, 8.0)

# `distance` and `contact` can take a `criteria` keyword argument with one of
# the following values: `Heavy`, `All`, `CA`, `CB` (it uses `CA` for `GLY`).

distance(res_i, res_j, criteria="CB")

# ### Exercise 2
# 4
#
# How many missing residues are in the chain A

# Write a function that returns the `Set` of residues in the first vector that
# are in contact with the residues in the second vector:

function get_contacts(residues_i, residues_j; threshold::Float64=8.0)
	result = Set{PDBResidue}()
##   ...your code here...
#src	for res_i in residues_i
#src		for res_j in residues_j
#src			if contact(res_i, res_j, threshold)
#src				push!(result, res_i)
#src			end
#src		end
#src	end
	result
end

#-

using Test
@test get_contacts(pdb_res[[1, end]], pdb_res[2:3], threshold=6.0) == Set([pdb_res[1]])

# ### Exercise 3
# 4
#
# How many missing residues are in the chain A

# Use the `get_contacts` function to get all the residues from the chain A
# (protein) that are in contact with the chains C, D and E (DNA).

## ...your solution...

#src get_contacts([res for res in pdb_res if res.id.chain == "A"],
#src 			  [res for res in pdb_res if res.id.chain in Set(["C", "D", "E"])])

# ## PDB Plots
#
# You can use Plots to get an idea of where your residues are:

using Plots
plotlyjs()

#-

plot(pdb_res)

# Or use Bio3DView to get an interactive view (but we need to save the residues
# in an uncompressed PDB file first):

write("selected_residues.pdb", pdb_res, PDBFile)

#-

using Bio3DView
viewfile("selected_residues.pdb", "pdb")

# ## SIFTS
#
# We can download the XML SIFTS file of the PDB using the SIFTS module of MIToS.
# It has a residue level mapping between databases and information about the
# structure.

using MIToS.SIFTS

const sifts_file = downloadsifts(pdb_id)

#-

const sifts_res = read(sifts_file, SIFTSXML)

# Similar to `PDBResidue`, a `SIFTSResidue` contains information about a
# single residue and their fields can be accessed using dots:

sifts_res[1]

# In this case, the first residue is missing in the structure:

sifts_res[1].missing

#-

sifts_res[end]

#-

sifts_res[end].missing

# #### Exercise 4
#
# How many missing residues are in the chain A?

## ...your code here...
# sum(res.missing for res in sifts_res if res.PDB.chain == "A")
