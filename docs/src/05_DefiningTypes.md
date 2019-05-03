```@meta
EditURL = "https://github.com/TRAVIS_REPO_SLUG/blob/master/"
```

# Defining your own types

[![](https://mybinder.org/badge_logo.svg)](https://mybinder.org/v2/gh/TRAVIS_REPO_SLUG/gh-pages?filepath=TRAVIS_TAG/notebooks/05_DefiningTypes.ipynb)
[![](https://img.shields.io/badge/show-nbviewer-579ACA.svg)](https://nbviewer.jupyter.org/github/TRAVIS_REPO_SLUG/blob/gh-pages/TRAVIS_TAG/notebooks/05_DefiningTypes.ipynb)

Julia user-defined types are as fast as built-in types. They are easy to
define:

```@example 05_DefiningTypes
abstract type AbstractFeature end
```

```@example 05_DefiningTypes
struct Exon{T} <: AbstractFeature where {T <: Integer}
	start::T
	stop::T
end
```

```@example 05_DefiningTypes
Exon(5, 10)
```

```@example 05_DefiningTypes
mutable struct MessengerRNA
	sequence::Vector{Char}
	exons::Vector{Exon}
	present::Vector{Bool}
end
```

```@example 05_DefiningTypes
mRNA = MessengerRNA(collect("ACTGTTGCATTGCAATTTAAGCAATGGCAAATAACATA"),
					[Exon(5,10), Exon(20,28), Exon(30,34)],
					[true, false, true])
```

You can access type fields using a dot:

```@example 05_DefiningTypes
mRNA.exons
```

#### Exercise 1

Define a function that takes a MessengerRNA object and return a list with the
sequences (as strings) of the exons present in the transcript, i.e.
`["TTGCAT", "AATAA"]`

```@example 05_DefiningTypes
# ... your function here ...
```

*This page was generated using [Literate.jl](https://github.com/fredrikekre/Literate.jl).*

