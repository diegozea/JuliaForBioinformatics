using JuliaForBioinformatics
using Test

@testset "JuliaForBioinformatics.jl" begin

    @testset "Type tree" begin

        @test show_type_tree(Number) === nothing
        
        @test_throws ArgumentError show_type_tree(Any)
    end
end
