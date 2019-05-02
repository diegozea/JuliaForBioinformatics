"""
Recursive function to print the type tree for a given `type`, including its
supertype and all its subtypes.
"""
function show_type_tree(type, indentation_level=0)
    if type === Any
        throw(ArgumentError("Any is subtype and supertype of Any"))
    end
    if indentation_level == 0
        println(supertype(type))
        indentation_level += 1
    end
    println("    " ^ indentation_level, type)
    for subtype in subtypes(type)
            show_type_tree(subtype, indentation_level + 1)
    end
end
