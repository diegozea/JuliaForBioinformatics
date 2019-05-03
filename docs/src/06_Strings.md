```@meta
EditURL = "https://github.com/TRAVIS_REPO_SLUG/blob/master/"
```

# Working with Strings

[![](https://mybinder.org/badge_logo.svg)](https://mybinder.org/v2/gh/TRAVIS_REPO_SLUG/gh-pages?filepath=TRAVIS_TAG/notebooks/06_Strings.ipynb)
[![](https://img.shields.io/badge/show-nbviewer-579ACA.svg)](https://nbviewer.jupyter.org/github/TRAVIS_REPO_SLUG/blob/gh-pages/TRAVIS_TAG/notebooks/06_Strings.ipynb)

## Regex

You can also use [regular expressions](https://docs.julialang.org/en/v1/manual/strings/#Regular-Expressions-1).
They are very useful to parse text files.

```@example 06_Strings
line = ">sp|O43521|B2L11_HUMAN Bcl-2-like protein 11 OS=Homo sapiens OX=9606 GN=BCL2L11 PE=1 SV=1"
```

```@example 06_Strings
regex = r"^>\w+\|(\w+)\|"
```

```@example 06_Strings
m = match(regex, line)
```

```@example 06_Strings
if m !== nothing
    println(m[1])
end
```

## String interpolation

You can [interpolate values](https://docs.julialang.org/en/v1/manual/strings/#string-interpolation-1),
single variables or the result of more complex expressions, into
strings using `$`:

```@example 06_Strings
a = 1
b = 2
"$a + $b is $(a + b)"
```

*This page was generated using [Literate.jl](https://github.com/fredrikekre/Literate.jl).*

