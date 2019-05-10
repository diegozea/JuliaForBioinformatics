module JuliaForBioinformatics

using InteractiveUtils

export show_type_tree,
	   cp_notebooks

include("type_tree.jl")

function cp_notebooks(dest=homedir())
	note_path = abspath(@__DIR__, "..", "docs", "src", "notebooks")
	for file in readdir(note_path)
		@show file
		try
			cp(joinpath(note_path, file), joinpath(dest, file), force=false)
			println("       copied!")
		catch
			println("       skipped!")
		end
	end
end

end # module
