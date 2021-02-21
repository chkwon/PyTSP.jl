using PyTSP
using Test

@testset "PyTSP.jl" begin
    #  random TSP instance
    n_cities = 300
    x = rand(n_cities) .* 100000
    y = rand(n_cities) .* 100000

    # The Concorde TSL Solver via pyconcorde
    time_concorde = @elapsed tour_concorde, length_concorde = solve_TSP_Concorde(x, y, norm="EUC_2D")
    length_concorde_float = tour_length(tour_concorde, x, y)

    # The LKH Heuristic via elkai 
    time_LKH = @elapsed tour_LKH, length_LKH = solve_TSP_LKH(x, y, dtype="int")
    gap = (length_LKH - length_concorde) / length_LKH * 100 
    gap = round(gap * 100) / 100 


    # Compare the solutions 
    println("============ n_cities = $n_cities ======================")
    @show tour_concorde 
    @show tour_LKH 
    println("Concorde      Tour Length: $length_concorde ($time_concorde seconds) (float length=$length_concorde_float)")
    println("LKH           Tour Length: $length_LKH ($time_LKH seconds) (gap = $gap %)")

    @test isapprox(length_concorde, length_LKH)
end
