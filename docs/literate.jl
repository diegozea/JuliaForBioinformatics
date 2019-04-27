using Literate, JuliaForBioinformatics

REPO = abspath(@__DIR__, "..")
MD_OUTPUT = joinpath(@__DIR__, "src")
NB_OUTPUT = joinpath(@__DIR__, "src", "notebooks")

for file in [ "01_Introduction.jl",
              "02_DataStructures.jl",
              "03_Files_Homework.jl" ]
    Literate.markdown(joinpath(REPO, "src", "Introduction", file),
        MD_OUTPUT, execute=false, documenter=true)
    Literate.notebook(joinpath(REPO, "src", "Introduction", file),
        NB_OUTPUT, execute=false, documenter=true)
end

for file in [ "04_Strings.jl",
              "05_Stats.jl" ]
    Literate.markdown(joinpath(REPO, "src", "Advance", file),
        MD_OUTPUT, execute=false, documenter=true)
    Literate.notebook(joinpath(REPO, "src", "Advance", file),
        NB_OUTPUT, execute=false, documenter=true)
end
