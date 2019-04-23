using Literate, JuliaForBioinformatics

REPO = abspath(@__DIR__, "..")
MD_OUTPUT = joinpath(@__DIR__, "src")
NB_OUTPUT = joinpath(@__DIR__, "src", "notebooks")

for file in [ "01_Introduction.jl",
              "02_DataStructures.jl",
              "03_Files.jl",
              "04_Stats.jl" ]
    Literate.markdown(joinpath(REPO, "src", "Introduction", file),
        MD_OUTPUT, execute=false, documenter=true)
    Literate.notebook(joinpath(REPO, "src", "Introduction", file),
        NB_OUTPUT, execute=false, documenter=true)
end
