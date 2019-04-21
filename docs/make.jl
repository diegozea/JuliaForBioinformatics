using Documenter, JuliaForBioinformatics

makedocs(;
    modules=[JuliaForBioinformatics],
    format=Documenter.HTML(),
    pages=[
        "Home" => "index.md",
    ],
    repo="https://github.com/diegozea/JuliaForBioinformatics.jl/blob/{commit}{path}#L{line}",
    sitename="JuliaForBioinformatics.jl",
    authors="Diego Javier Zea",
    assets=[],
)

deploydocs(;
    repo="github.com/diegozea/JuliaForBioinformatics.jl",
)
