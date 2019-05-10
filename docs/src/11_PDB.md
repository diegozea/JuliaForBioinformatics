```@meta
EditURL = "https://github.com/TRAVIS_REPO_SLUG/blob/master/"
```

# MSA and structures

[![](https://mybinder.org/badge_logo.svg)](https://mybinder.org/v2/gh/TRAVIS_REPO_SLUG/gh-pages?filepath=TRAVIS_TAG/notebooks/11_PDB.ipynb)
[![](https://img.shields.io/badge/show-nbviewer-579ACA.svg)](https://nbviewer.jupyter.org/github/TRAVIS_REPO_SLUG/blob/gh-pages/TRAVIS_TAG/notebooks/11_PDB.ipynb)

For this example, we use the Multiple Sequence Alignment (MSA) of the
*Mu DNA-binding domain*.

```@example 11_PDB
using MIToS.Pfam
using MIToS.MSA

const pfam_file = downloadpfam("PF02316")
const msa = read(pfam_file,
				 Stockholm,
				 generatemapping=true,
				 useidcoordinates=true)
```

We use the `getseq2pdb` function to look into the Pfam annotations for PDBs:

```@example 11_PDB
const seq2pdb = getseq2pdb(msa)
```

For this example, we use the crystallographic structure 4FCY...

```@example 11_PDB
selected = [ (seq, pdb, chain) for (seq, pdbs) in seq2pdb
				for (pdb, chain) in pdbs if pdb == "4FCY" ]
```

...and we take the first one

```@example 11_PDB
seq_id, pdb_id, chain = selected[1]
```

We download and read the PDB file

```@example 11_PDB
using MIToS.PDB
pdb_file = downloadpdb(pdb_id, format=PDBFile)
```

```@example 11_PDB
const pdb_res = read(pdb_file, PDBFile)
```

Each PDBResidue contains the information in the ATOM and HETATM PDB lines:

```@example 11_PDB
first_residue = pdb_res[1]
```

You can access the information by accessing the field names:

```@example 11_PDB
first_residue.id.name
```

#### Exercise 1
4

How many missing residues are in the chain A

How many chains are in the PDB?

**Hint:** You can use `Set` or `unique`

There are 5 chains: A, B, C, D, E

## Distances and contacts

MIToS PDB module has functions to measure distance between residues and
identify contacts:

```@example 11_PDB
res_i = pdb_res[1]
res_j = pdb_res[4]
distance(res_i, res_j)
```

`contact(i, j, threshold)` is faster than `distance(i, j) < threshold`

```@example 11_PDB
contact(res_i, res_j, 8.0)
```

`distance` and `contact` can take a `criteria` keyword argument with one of
the following values: `Heavy`, `All`, `CA`, `CB` (it uses `CA` for `GLY`).

```@example 11_PDB
distance(res_i, res_j, criteria="CB")
```

### Exercise 2
4

How many missing residues are in the chain A

Write a function that returns the `Set` of residues in the first vector that
are in contact with the residues in the second vector:

```@example 11_PDB
function get_contacts(residues_i, residues_j; threshold::Float64=8.0)
	result = Set{PDBResidue}()
#   ...your code here...
	result
end
```

```@example 11_PDB
using Test
@test get_contacts(pdb_res[[1, end]], pdb_res[2:3], threshold=6.0) == Set([pdb_res[1]])
```

### Exercise 3
4

How many missing residues are in the chain A

Use the `get_contacts` function to get all the residues from the chain A
(protein) that are in contact with the chains C, D and E (DNA).

```@example 11_PDB
# ...your solution...
```

## PDB Plots

You can use Plots to get an idea of where your residues are:

```@example 11_PDB
using Plots
plotlyjs()
```

```@example 11_PDB
plot(pdb_res)
```

Or use Bio3DView to get an interactive view (but we need to save the residues
in an uncompressed PDB file first):

```@example 11_PDB
write("selected_residues.pdb", pdb_res, PDBFile)
```

```@example 11_PDB
using Bio3DView
viewfile("selected_residues.pdb", "pdb")
```

## SIFTS

We can download the XML SIFTS file of the PDB using the SIFTS module of MIToS.
It has a residue level mapping between databases and information about the
structure.

```@example 11_PDB
using MIToS.SIFTS

const sifts_file = downloadsifts(pdb_id)
```

```@example 11_PDB
const sifts_res = read(sifts_file, SIFTSXML)
```

Similar to `PDBResidue`, a `SIFTSResidue` contains information about a
single residue and their fields can be accessed using dots:

```@example 11_PDB
sifts_res[1]
```

In this case, the first residue is missing in the structure:

```@example 11_PDB
sifts_res[1].missing
```

```@example 11_PDB
sifts_res[end]
```

```@example 11_PDB
sifts_res[end].missing
```

#### Exercise 4

How many missing residues are in the chain A?

```@example 11_PDB
# ...your code here...
```

sum(res.missing for res in sifts_res if res.PDB.chain == "A")

*This page was generated using [Literate.jl](https://github.com/fredrikekre/Literate.jl).*

