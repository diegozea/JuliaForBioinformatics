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

for file in [ "04_HowJuliaWorks.jl",
              "05_DefiningTypes.jl",
              "06_Strings.jl",
              "07_Stats.jl" ]
    Literate.markdown(joinpath(REPO, "src", "Advance", file),
        MD_OUTPUT, execute=false, documenter=true)
    Literate.notebook(joinpath(REPO, "src", "Advance", file),
        NB_OUTPUT, execute=false, documenter=true)
end

# copy some figures to the build directory
cp(joinpath(REPO, "src", "Advance", "figures", "JuliaCompiler.png"),
    joinpath(MD_OUTPUT, "JuliaCompiler.png"); force = true)
cp(joinpath(REPO, "src", "Advance", "figures", "JuliaCompiler.png"),
    joinpath(NB_OUTPUT, "JuliaCompiler.png"); force = true)
