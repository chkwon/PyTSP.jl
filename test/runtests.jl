using PyTSP
using Test

@testset "PyTSP.jl" begin
    @testset "Basic TSP solver tests" begin
        #  random TSP instance
        n_cities = 20
        factor = 1e5
        x = rand(n_cities) .* factor
        y = rand(n_cities) .* factor

        # The Concorde TSL Solver via pyconcorde
        time_concorde = @elapsed tour_concorde, length_concorde = solve_TSP_Concorde(x, y, norm="EUC_2D")

        # The LKH Heuristic via elkai 
        time_LKH = @elapsed tour_LKH, length_LKH = solve_TSP_LKH(x, y)
        gap = (length_LKH - length_concorde) / length_LKH * 100 
        gap = round(gap * 100) / 100 

        # Compare the solutions 
        println("============ n_cities = $n_cities ======================")
        @show tour_concorde 
        @show tour_LKH 
        println("Concorde      Tour Length: $length_concorde ($time_concorde seconds)")
        println("LKH           Tour Length: $length_LKH ($time_LKH seconds) (gap = $gap %)")

        @test isapprox(length_concorde, length_LKH; atol=2)
    end

    @testset "LKH type tests" begin
        #  random TSP instance
        n_cities = 20
        factor = 1e5
        x = rand(n_cities) .* factor
        y = rand(n_cities) .* factor

        tour_LKH_int1, length_LKH_int1 = solve_TSP_LKH(x, y)

        M = distance_matrix(x, y)
        tour_LKH_int2, length_LKH_int2 = solve_TSP_LKH(M)
        
        N = distance_matrix(x, y) .* 1.0
        tour_LKH_float, length_LKH_float = solve_TSP_LKH(N)

        @test isa(length_LKH_int1, Int)
        @test isa(length_LKH_int2, Int)
        @test isa(length_LKH_float, Float64)
        
        @test isapprox(length_LKH_int1, length_LKH_int2)
    end
end