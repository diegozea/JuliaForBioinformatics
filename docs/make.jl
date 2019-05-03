using Documenter, JuliaForBioinformatics

include("literate.jl")

makedocs(;
    modules=[JuliaForBioinformatics],
    format=Documenter.HTML(prettyurls = get(ENV, "CI", nothing) == "true"),
    pages=[
        "Home" => "index.md",
        "Introduction" => [
            "01_Introduction.md"
            "02_DataStructures.md"
            "03_Files_Homework.md"
        ],
        "Advance" => [
            "04_HowJuliaWorks.md"
            "05_DefiningTypes.md"
            "06_Strings.md"
            "07_Stats.md"
            "08_Packages_Homework.md"
        ],
        "API" => "api.md"
    ],
    # repo="https://github.com/diegozea/JuliaForBioinformatics.jl/blob/{commit}{path}#L{line}",
    sitename="JuliaForBioinformatics",
    authors="Diego Javier Zea"
)

deploydocs(;
    repo="github.com/diegozea/JuliaForBioinformatics",
)
