include("utils.jl")

#  random TSP instance
n_cities = 50
x = rand(n_cities)
y = rand(n_cities)

# The Concorde TSL Solver via pyconcorde
using PyCall
Concorde = pyimport("concorde.tsp")
solver = Concorde.TSPSolver.from_data(x, y, norm="GEOM")
tour_data = solver.solve()
tour_concorde = tour_data[1] .+ 1  # 0-index -> 1-index
length_concorde = tour_length(tour_concorde, x, y) 

# The LKH Heuristic via elkai 
using PyCall 
Elkai = pyimport("elkai")
M = construct_distance_matrix(x, y)
tour_LKH = Elkai.solve_float_matrix(M) .+ 1 #adding 1 for indexing
length_LKH = tour_length(tour_LKH, M)
gap = (length_LKH - length_concorde) / length_LKH * 100 
gap = round(gap * 100) / 100 

# TravelingSalesmanExact.jl 
using TravelingSalesmanExact, GLPK
set_default_optimizer!(GLPK.Optimizer)
cities = [ [x[i], y[i]] for i in 1:n_cities]
tour_jl, cost_jl = get_optimal_tour(cities; verbose = true)
length_jl = tour_length(tour_jl, x, y)

# Compare the solutions 
println("============ n_cities = $n_cities ======================")
@show tour_concorde 
@show tour_LKH 
@show tour_jl 
println("Concorde      Tour Length: ", length_concorde)
println("LKH           Tour Length: ", length_LKH, "      (gap = ", gap, "%)")
println("Julia Package Tour Length: ", length_jl)