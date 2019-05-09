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
