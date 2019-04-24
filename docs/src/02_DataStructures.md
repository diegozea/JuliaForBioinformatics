```@meta
EditURL = "https://github.com/TRAVIS_REPO_SLUG/blob/master/"
```

# Data Structures

[![](https://mybinder.org/badge_logo.svg)](https://mybinder.org/v2/gh/TRAVIS_REPO_SLUG/gh-pages?filepath=TRAVIS_TAG/notebooks/02_DataStructures.ipynb)
[![](https://img.shields.io/badge/show-nbviewer-579ACA.svg)](https://nbviewer.jupyter.org/github/TRAVIS_REPO_SLUG/blob/gh-pages/TRAVIS_TAG/notebooks/02_DataStructures.ipynb)

## Arrays

Julia has a nice and flexible array interface. Arrays can have an arbitrary
number of dimensions. Let's define a one-dimetional array (i.e. a vector):

```@example 02_DataStructures
vector = [1.0, 2.0, 3.0, 4.0, 5.0, 6.0]
```

The first index of an array in Julia is `1`:

```@example 02_DataStructures
vector[1]
```

You can use `end` to access the last element of an array:

```@example 02_DataStructures
vector[end]
```

Use ranges (`start:end`) to get a slice of the array:

```@example 02_DataStructures
vector[2:4]
```

Ranges in Julia are iterable objects:

```@example 02_DataStructures
indexes = 2:4
```

```@example 02_DataStructures
for i in indexes
	@show i
end
```

Julia arrays, like the strings and ranges, are also iterables:

```@example 02_DataStructures
for element in vector
	println(element)
end
```

#### Exercise 1

Write a function to return the distance between two three dimensional points,
i.e. two vector of three elements. You should use a `for` loop over a range
and index the vectors.

```@example 02_DataStructures
# function distance(a, b...
```

```@example 02_DataStructures
using Test
A = [1.25, 2.0, 3.6]
B = [-3.5, 4.7, 5.0]
@test distance(A, B) ≈ hypot((A - B)...)
```

`...` "splats" the values contained in an iterable collection into a
function call as individual arguments, e.g:

```@example 02_DataStructures
vector = [1, 2, 3]
hypot(vector...)  # hypot(1, 2, 3)
```

You can use `push!` to add one element to the end of an array

```@example 02_DataStructures
vector = [1,2,3]
```

```@example 02_DataStructures
push!(vector, 4)
```

There are other useful
[dequeues functions](https://docs.julialang.org/en/v1/base/collections/#Dequeues-1)
defined in Julia, e.g. `pop!`, `append!`.

In Julia, by convention, all the functions that modify their arguments
should end with a bang or exclamation mark, `!`, see the
[style guide](https://docs.julialang.org/en/v1/manual/style-guide/index.html#Append-!-to-names-of-functions-that-modify-their-arguments-1).

### Vectorized operations

You can use a dot, `.`,  to indicate that a function, e.g. `log.(x)`, or
operator, e.g. `x .^ y`,  should be applied element by element, see
[dot syntax](https://docs.julialang.org/en/v1/manual/functions/#man-vectorized-1):

```@example 02_DataStructures
a = [1, -2, -3]
b = [-2, -4, 0]
a .* b
```

This notation allows vectorizing any function, even element-wise functions
defined by the user:

```@example 02_DataStructures
f(x) = 3.45x + 4.76

f.(sin.(a))
```

Multiple vectorized operations get
[fused in a single loop](https://julialang.org/blog/2017/01/moredots)
without temporal arrays.

### Comprehensions

You can use [comprehensions](https://docs.julialang.org/en/v1/manual/arrays/#Comprehensions-1)
to create arrays and perform some operation

```@example 02_DataStructures
[ 2x for x in 1:10 ]
```

```@example 02_DataStructures
result = [ 2x for x in 1:10 if x % 2 == 0 ]
```

#### Exercise 3

Write the equivalent of the previous expression using a `for` loop and `push!`.

```@example 02_DataStructures
# result = []
# for ...
```

### Matrices

Matrices, bidimentional arrays, can be defined with the following notation:

```@example 02_DataStructures
matrix = [ 1.0 4.0 7.0
           2.0 5.0 8.0
		   3.0 6.0 9.0 ]
```

You can use linear indexing (Julia arrays are stored in column major order)
to access an element

```@example 02_DataStructures
matrix[2]
```

Or using one index by dimension, i.e. `matrix[row_index, col_index]` :

```@example 02_DataStructures
matrix[2, 1]
```

You can also use ranges and `end`. The colon, `:`, means that all the indices
from that dimension should be used:

```@example 02_DataStructures
matrix[2:end, :]
```

#### Comprehensions

You can also use comprehensions to create matrices. In fact, you can create
array of any desired dimension:

```@example 02_DataStructures
[ x + y for x in 1:5, y in 1:10 ]
```

## Dictionaries and pairs

Dictionaries (hash tables) stores key => values pairs:

```@example 02_DataStructures
dictionary = Dict('A' => 'T', 'C' => 'G', 'T' => 'A', 'G' => 'C')
```

You can get a value by indexing with the key:

```@example 02_DataStructures
dictionary['A'] # get(dictionary, 'A')
```

If the key is not present in the dictionary, an error is raised:

```@example 02_DataStructures
dictionary['N'] # get(dictionary, 'N')
```

The function `get` allows to specify a default value that is returned if
the key is absent in the dictionary:

```@example 02_DataStructures
get(dictionary, 'N', '-')
```

A nice thing about hash tables (dictionary keys, sets) is that test
membership is $O(1)$ while it is $O(N)$ in lists/vectors/arrays:

```@example 02_DataStructures
'N' in keys(dictionary)
```

A dictionary gives pairs when it is iterated:

```@example 02_DataStructures
for pair in dictionary
	println("pair: ", pair)  # each pair is key => value
	println("key: ", pair.first)  # pair.first == pair[1]
	println("value: ", pair.second)  # pair.second == pair[2]
end
```

## Tuples

Tuples are immutable collections, while arrays are mutable:

```@example 02_DataStructures
point = [1.0, 2.0, 3.0]  # vector
point[1] = 10.0
point
```

```@example 02_DataStructures
point = (1.0, 2.0, 3.0)  # tuple
```

```@example 02_DataStructures
point[1] = 10.0
```

You can index a tuple, like a vector, to get the stored element(s):

```@example 02_DataStructures
point[1:2]
```

Tuples, vectors, pairs and other iterables can be easily unpacked using an
assignation:

```@example 02_DataStructures
x, y, z = point
y
```

You can use this unpacking when iterating a dictionary:

```@example 02_DataStructures
for (key, value) in dictionary
	println("key: ", key, " value: ", value)
end
```

#### Exercise 3

Write a function to return the reverse complement of a DNA sequence (string)
using a dictionary, the `join` function and the `Base.Iterators.reverse`
iterator. It should use a 'N' as complementary of any base different from
'A', 'C', 'T' or 'G':

```@example 02_DataStructures
# function reverse_complement(...
```

```@example 02_DataStructures
using Test
@test reverse_complement("ACTGGTCCCNT") == "ANGGGACCAGT"
```

### Named tuples

They can be an easy and fast way to store data:

```@example 02_DataStructures
point = (x=1.0, y=2.0, z=3.0)  # named tuple
```

You can use `namedtuple.name` to access a particular element:

```@example 02_DataStructures
point.y
```

## Sets

You can use `Set` to represent a set of unique elements:

```@example 02_DataStructures
set = Set([1, 2, 2, 3, 3, 3, 4, 4, 4, 4])
```

Test membership is $O(1)$

```@example 02_DataStructures
4 in set
```

You can get the intersection of two sets using `intersect` or
`∩` (`\cap<TAB>`)

```@example 02_DataStructures
set_a = Set([1, 2, 3])
set_b = Set([2, 3, 4])
set_a ∩ set_b  # intersect(set, set_b)
```

And the unioin of to sets using `union` or `∪` (`\cup<TAB>`)

```@example 02_DataStructures
set_a ∪ set_b  # union(set, set_b)
```

The symmetric difference, i.e. disjunctive union, of two sets

```@example 02_DataStructures
symdiff(set_a, set_b)
```

*This page was generated using [Literate.jl](https://github.com/fredrikekre/Literate.jl).*

