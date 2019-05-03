# # Defining your own types
#
#md # [![](https://mybinder.org/badge_logo.svg)](@__BINDER_ROOT_URL__notebooks/05_DefiningTypes.ipynb)
#md # [![](https://img.shields.io/badge/show-nbviewer-579ACA.svg)](@__NBVIEWER_ROOT_URL__notebooks/05_DefiningTypes.ipynb)
#
# Julia user-defined types are as fast as built-in types. They are easy to
# define:
#

abstract type AbstractFeature end

#-

struct Exon{T} <: AbstractFeature where {T <: Integer}
	start::T
	stop::T
end

#-

Exon(5, 10)

#-

mutable struct MessengerRNA
	sequence::Vector{Char}
	exons::Vector{Exon}
	present::Vector{Bool}
end

#-

mRNA = MessengerRNA(collect("ACTGTTGCATTGCAATTTAAGCAATGGCAAATAACATA"),
					[Exon(5,10), Exon(20,28), Exon(30,34)],
					[true, false, true])

# You can access type fields using a dot:

mRNA.exons

# #### Exercise 1
#
# Define a function that takes a MessengerRNA object and return a list with the
# sequences (as strings) of the exons present in the transcript, i.e.
# `["TTGCAT", "AATAA"]`

## ... your function here ...
