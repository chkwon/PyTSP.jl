include("utils.jl")

using PyCall
using TravelingSalesmanExact

function solve_TSP_Concorde(x, y; norm="EUC_2D")
    Concorde = pyimport("concorde.tsp")
    solver = Concorde.TSPSolver.from_data(x, y, norm)
    tour_data = solver.solve()
    tour_concorde = tour_data[1] .+ 1  # 0-index -> 1-index
    length_concorde = tour_length(tour_concorde, x, y) 
    length_concorde = Int(tour_data[2])
    return tour_concorde, length_concorde
end

function solve_TSP_LKH(M; dtype="int")
    Elkai = pyimport("elkai")
    if dtype=="int" 
        M = Int.(round.(M))
        tour_LKH = Elkai.solve_int_matrix(M) .+ 1 #adding 1 for indexing
    elseif dtype == "float" 
        tour_LKH = Elkai.solve_float_matrix(M) .+ 1 #adding 1 for indexing
    end
    length_LKH = tour_length(tour_LKH, M)
    return tour_LKH, length_LKH
end

function solve_TSP_LKH(x, y; dtype="int")
    Elkai = pyimport("elkai")
    M = construct_distance_matrix(x, y)
    return solve_TSP_LKH(M, dtype=dtype)
end

function solve_TSP_JuliaExact(x, y, optimizer)
    set_default_optimizer!(optimizer)
    cities = [ [x[i], y[i]] for i in 1:n_cities]
    tour_jl, cost_jl = get_optimal_tour(cities; verbose = true)
    length_jl = tour_length(tour_jl, x, y)
    return tour_jl, length_jl
end

