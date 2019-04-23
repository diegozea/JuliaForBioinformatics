using Documenter, JuliaForBioinformatics

include("literate.jl")

makedocs(;
    modules=[JuliaForBioinformatics],
    format=Documenter.HTML(),
    pages=[
        "Home" => "index.md",
        "Introduction" => [
            "01_Introduction.md"
            "02_DataStructures.md"
            "03_Files.md"
            "04_Stats.md"
        ]
    ],
    repo="https://github.com/diegozea/JuliaForBioinformatics.jl/blob/{commit}{path}#L{line}",
    sitename="JuliaForBioinformatics.jl",
    authors="Diego Javier Zea"
)

deploydocs(;
    repo="github.com/diegozea/JuliaForBioinformatics.jl",
)
