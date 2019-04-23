using Literate, JuliaForBioinformatics

REPO = abspath(pathof(JuliaForBioinformatics), "..", "..")

MD_OUTPUT = joinpath(REPO, "docs", "src")

Literate.markdown(joinpath(REPO, "src", "Introduction", "01_Introduction.jl"),
    MD_OUTPUT, execute=false, documenter=true)
Literate.markdown(joinpath(REPO, "src", "Introduction", "02_DataStructures.jl"),
    MD_OUTPUT, execute=false, documenter=true)
Literate.markdown(joinpath(REPO, "src", "Introduction", "03_Files.jl"),
    MD_OUTPUT, execute=false, documenter=true)
Literate.markdown(joinpath(REPO, "src", "Introduction", "04_Stats.jl"),
    MD_OUTPUT, execute=false, documenter=true)

NB_OUTPUT = joinpath(REPO, "notebooks")

Literate.notebook(joinpath(REPO, "src", "Introduction", "01_Introduction.jl"),
    joinpath(NB_OUTPUT, "Introduction"), execute=false)
Literate.notebook(joinpath(REPO, "src", "Introduction", "02_DataStructures.jl"),
    joinpath(NB_OUTPUT, "Introduction"), execute=false)
Literate.notebook(joinpath(REPO, "src", "Introduction", "03_Files.jl"),
    joinpath(NB_OUTPUT, "Introduction"), execute=false)
Literate.notebook(joinpath(REPO, "src", "Introduction", "04_Stats.jl"),
    joinpath(NB_OUTPUT, "Introduction"), execute=false)
