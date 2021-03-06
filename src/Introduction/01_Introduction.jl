# # Introduction
#
#md # [![](https://mybinder.org/badge_logo.svg)](@__BINDER_ROOT_URL__notebooks/01_Introduction.ipynb)
#md # [![](https://img.shields.io/badge/show-nbviewer-579ACA.svg)](@__NBVIEWER_ROOT_URL__notebooks/01_Introduction.ipynb)
#
# Let's start with a classic:

message = "Hello World!"

#-

println(message)

# Julia is a general purpose programming language designed with scientific
# computing and mathematics in mind. For this reason, some Julia expressions
# look like mathematics.
#
# For example, let's write a Julia function to calculate
# a circle’s circumference $C$ as a function of the radius $r$:
#
# $C = 2 \pi r$

r = 10

C = 2π*r

# `π` is one of the
# [mathematical constants](https://docs.julialang.org/en/v1.1/base/numbers/#General-Number-Functions-and-Constants-1)
# defined in Julia. You can write `π` by typing `\pi` and pressing `<TAB>` in
# the REPL:

π

#-

pi

# The multiplication operator `*` is not needed when a literal number
# (e.g. `2`) is placed just before a variable or constant (e.g. `π`),
# see [*Numeric Literal Coefficients*](https://docs.julialang.org/en/v1.1/manual/integers-and-floating-point-numbers/#man-numeric-literal-coefficients-1).
# That makes polynomial expressions much cleaner:

f(x) = 1.56 + 2.24x + 3.47x^2

#-

f(0.04)

# This one-line function definition, i.e. `function_name(arguments) = body`, is
# the simplest we can use in Julia.

# #### Exercise 1
#
# Define an one-line function to calculate the length of the  hypotenuse of a
# right-angled triangle with catheti (legs) $a$ and $b$ as
# $\sqrt{a^{2} + b^{2}}$ using the `sqrt()` function:

## hypotenuse(...

# If your solution is correct, the following test should pass without errors.

using Test

# The `Test` module exports the `@test` macro, useful for writing unit tests of
# the code. We are going to use `≈`, `\approx<TAB>`, (`a ≈ b` or
# `isapprox(a, b)`) test if two values can be equal taking into account
# floating point errors. :

@test hypotenuse(2, 5) ≈ hypot(2, 5)

# In real life, you can use the function `hypot` to avoid
# [underflow and overflow problems](https://www.johndcook.com/blog/2010/06/02/whats-so-hard-about-finding-a-hypotenuse/).

# ## Control Flow
#
# ### `if`

distance = hypot(1.0, 3.0, 2.5)

#-

if distance <= 2.08  # Å
    "Disulphide"
elseif distance <= 6  # Å
    "Contact"
else
    "Not interacting"
end

# Each condition should be a boolean variable (`true` or `false`) or an
# expression that evaluates to a boolean value.

# ### Short-circuit evaluation

condition = true
condition && println("It's true!")

# #### Exercise 2
#
# Can you write the equivalent expression using `if` ?

## if ...

# ### Ternary operator

condition = true
result = condition ? "👍" : "👎"

# This is equivalent to:

result = if condition
        "👍"
    else
        "👎"
end

#-

result

# ## `for` loops

dna = "ATGCAT"  # dna is a string

for base in dna
    println(base)  # base is a character
end

# `for base = dna` and `for base ∈ dna` are also a possible notations, i.e.
# using `=` or `∈` instead of `in`:

for base ∈ dna
    println(base)
end

# Julia has a nice unicode support and unicode characters can be used in
# variables names, operators, etc. You can write `∈` in the REPL by typing `\in`
# and pressing the `<TAB>` key.

# ## Functions
#
# ### One-line syntax

"Return the number of codons in the sequence."
codon_number(seq) = div(length(seq), 3) # This is a Julia comment

# A strings before the function declaration is used as docstring. You can access
# the function documentation by typing `?` in the REPL and the name of the
# function, e.g.: `?codon_number`

## Try to look at the documentation of condon_number

#-

codon_number(dna)

# ### Multi-line syntax

# Functions with longer bodies are defined using the `function` keyword:

"Returns the GC number in a given sequence."
function count_gc(string)
    count = 0
    for char in string
        if char == 'C' || char == 'G'  # || is the short-circuiting or.
            ## ' ' (instead of " ") is used to define a character.
            count += 1  # i.e. count = count + 1
        end
    end
    count  # i.e. return count
end

#-

count_gc(dna)

# By default, a function returns the result of the last evaluated expression,
# `count` in the previous example. Otherwise, the keyword `return` should be
# used:

"""
`is_dna` iterates a string and returns:
- `false` if a character different from **A, C, T or G** is found
- `true` otherwise
"""
function is_dna(string)
    for char in string
        if char != 'A' && char != 'C' && char != 'T' && char != 'G'
            return false
        end
    end
    true
end

#-

is_dna("ACHL")

# Here, the `return` keyword is used inside the loop to return `false` as soon
# as an incorrect character is found.
#
# `"""` defines multiline strings. In this example, the multiline string is the
# documentation string of the function. Markdown syntax can be used in
# docstrings.

#md ?is_dna
#nb ?is_dna

# #### Exercise 3
#
# Write a function that returns `true` if the given string (argument) has at
# least one `N` using the keywords `function`, `for`, `if` and `return`.

## has_n(...

# `@testset` is useful to aggregate tests for a particular functionality:

using Test
@testset "Exercise 3" begin
    @test has_n("ACTGN")
    @test !has_n("ACTG")
end

# #### Material
#
# You can find more complete information about
# [functions](https://docs.julialang.org/en/v1.1/manual/functions/)
# and [control flow](https://docs.julialang.org/en/v1.1/manual/control-flow/)
# statements in the Julia manual.
