using Literate, JuliaForBioinformatics

DOCS = @__DIR__
REPO = abspath(DOCS, "..")
MD_OUTPUT = joinpath(DOCS, "src")
NB_OUTPUT = joinpath(DOCS, "notebooks")


Literate.markdown(joinpath(REPO, "src", "Introduction", "01_Introduction.jl"),
    MD_OUTPUT, execute=false, documenter=true)
Literate.markdown(joinpath(REPO, "src", "Introduction", "02_DataStructures.jl"),
    MD_OUTPUT, execute=false, documenter=true)
Literate.markdown(joinpath(REPO, "src", "Introduction", "03_Files.jl"),
    MD_OUTPUT, execute=false, documenter=true)
Literate.markdown(joinpath(REPO, "src", "Introduction", "04_Stats.jl"),
    MD_OUTPUT, execute=false, documenter=true)



Literate.notebook(joinpath(REPO, "src", "Introduction", "01_Introduction.jl"),
    NB_OUTPUT, execute=false, documenter=true)
Literate.notebook(joinpath(REPO, "src", "Introduction", "02_DataStructures.jl"),
    NB_OUTPUT, execute=false, documenter=true)
Literate.notebook(joinpath(REPO, "src", "Introduction", "03_Files.jl"),
    NB_OUTPUT, execute=false, documenter=true)
Literate.notebook(joinpath(REPO, "src", "Introduction", "04_Stats.jl"),
    NB_OUTPUT, execute=false, documenter=true)
