# # Data Structures
#
# ## Arrays
#
# Julia has a nice and flexible array interface. Arrays can have an arbitrary
# number of dimensions. Let's define a one-dimetional array (i.e. a vector):

vector = [1.0, 2.0, 3.0, 4.0, 5.0, 6.0]

# The first index of an array in Julia is `1`:

vector[1]

# You can use `end` to access the last element of an array:

vector[end]

# Use ranges (`start:end`) to get a slice of the array:

vector[2:4]

# Julia arrays, like the strings, are iterables:

for element in vector
	println(element)
end

# Matrices, bidimentional arrays, can be defined with the following notation:

matrix = [ 1.0 4.0 7.0
           2.0 5.0 8.0
		   3.0 6.0 9.0 ]

# You can use linear indexing (Julia arrays are stored in column major order)
# to access an element

matrix[9]

# Or using one index by dimension, i.e. `matrix[row_index, col_index]` :

matrix[3, 3]

# You can also use ranges and `end`. The colon, `:`, means that all the indices
# from that dimension should be used:

matrix[2:end, :]

# ## Dictionaries and pairs
#
# Dictionaries (hash tables) stores key => values pairs:

dictionary = Dict('A' => 'T', 'C' => 'G', 'T' => 'A', 'G' => 'C')

# You can get a value by indexing with the key:

dictionary['A']

# If the key is not present in the dictionary, an error is raised:

dictionary['N']

# The function `get` allows to specify and default value that is returned is
# the key is absent in the dictionary:

get(dictionary, 'N', '-')

# A nice thing about hash tables (dictionary keys, sets) is that test
# membership is O(1) while it is O(N) in lists/vectors/arrays:

'N' in keys(dictionary)

# A dictionary gives pairs when it is iterated:

for pair in dictionary
	println(pair)  ## each pair is key => value
	println("key: ", pair.first)  ## pair.first == pair[1]
	println("value: ", pair.second)  ## pair.second == pair[2]
end

# ## Tuples
#
# Tuples are immutable collections, while arrays are mutable:

point = [1.0, 2.0, 3.0]  ## vector
point[1] = 10.0
point

#-

point = (1.0, 2.0, 3.0)  ## tuple
point[1] = 10.0

# You can index a tuple, like a vector, to get the stored element(s):

point[1:2]

# Tuples, vectors, pairs and other iterables can be easily unpacked using an
# assignation:

x, y, z = point
y

# You can use this unpacking when iterating a dictionary:

for (key, value) in dictionary
	println("key: ", key, " value: ", value)
end

# ### Named tuples
#
# They can be an easy and fast way to store data:

point = (x=1.0, y=2.0, z=3.0)  ## named tuple

# You can use `namedtuple.name` to access a particular element:

point.y

# ## Sets

set = Set([1, 2, 2, 3, 3, 3, 4, 4, 4, 4])

#-

for element in set
	println(element)
end

#-

1 in set

#-

set_b = Set([-1, 0, 1, 2])
set ∩ set_b  ## intersect(set, set_b)


# `\cap`

set ∪ set_b  ## union(set, set_b)

# `\cup`

symdiff(set, set_b)

#-

union!(set, set_b)

#-

set
