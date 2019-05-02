# # Working with Strings
#
#md # [![](https://mybinder.org/badge_logo.svg)](@__BINDER_ROOT_URL__notebooks/06_Strings.ipynb)
#md # [![](https://img.shields.io/badge/show-nbviewer-579ACA.svg)](@__NBVIEWER_ROOT_URL__notebooks/06_Strings.ipynb)
#
# ## Regex
#
# You can also use [regular expressions](https://docs.julialang.org/en/v1/manual/strings/#Regular-Expressions-1).
# They are very useful to parse text files.

line = ">sp|O43521|B2L11_HUMAN Bcl-2-like protein 11 OS=Homo sapiens OX=9606 GN=BCL2L11 PE=1 SV=1"

#-

regex = r"^>\w+\|(\w+)\|"

#-

m = match(regex, line)

#-

if m !== nothing
    println(m[1])
end

# ## String interpolation
#
# You can [interpolate values](https://docs.julialang.org/en/v1/manual/strings/#string-interpolation-1),
# single variables or the result of more complex expressions, into
# strings using `$`:

a = 1
b = 2
"$a + $b is $(a + b)"
