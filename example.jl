include("tsp_solvers.jl")

#  random TSP instance
n_cities = 100
x = rand(n_cities)
y = rand(n_cities)

# The Concorde TSL Solver via pyconcorde
time_concorde = @elapsed tour_concorde, length_concorde = solve_TSP(x, y, :Concorde)

# The LKH Heuristic via elkai 
time_LKH = @elapsed tour_LKH, length_LKH = solve_TSP(x, y, :LKH)
gap = (length_LKH - length_concorde) / length_LKH * 100 
gap = round(gap * 100) / 100 

# TravelingSalesmanExact.jl 
# Just for checking the solution
using Gurobi
optimizer = Gurobi.Optimizer
set_default_optimizer!(optimizer)
cities = [ [x[i], y[i]] for i in 1:n_cities]
time_jl = @elapsed tour_jl, cost_jl = get_optimal_tour(cities; verbose = true)
length_jl = tour_length(tour_jl, x, y)


# Compare the solutions 
println("============ n_cities = $n_cities ======================")
@show tour_concorde 
@show tour_LKH 
@show tour_jl 
println("Concorde      Tour Length: $length_concorde ($time_concorde seconds)")
println("LKH           Tour Length: $length_LKH ($time_LKH seconds) (gap = $gap %)")
println("Julia Package Tour Length: $length_jl ($time_jl seconds)")
