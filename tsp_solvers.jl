include("utils.jl")

using PyCall
using TravelingSalesmanExact

function solve_TSP_Concorde(x, y)
    Concorde = pyimport("concorde.tsp")
    solver = Concorde.TSPSolver.from_data(x, y, norm="GEOM")
    tour_data = solver.solve()
    tour_concorde = tour_data[1] .+ 1  # 0-index -> 1-index
    length_concorde = tour_length(tour_concorde, x, y) 
    return tour_concorde, length_concorde
end

function solve_TSP_LKH(x, y)
    Elkai = pyimport("elkai")
    M = construct_distance_matrix(x, y)
    tour_LKH = Elkai.solve_float_matrix(M) .+ 1 #adding 1 for indexing
    length_LKH = tour_length(tour_LKH, M)
    return tour_LKH, length_LKH
end

function solve_TSP_JuliaExact(x, y, optimizer)
    set_default_optimizer!(optimizer)
    cities = [ [x[i], y[i]] for i in 1:n_cities]
    tour_jl, cost_jl = get_optimal_tour(cities; verbose = true)
    length_jl = tour_length(tour_jl, x, y)
    return tour_jl, length_jl
end

function solve_TSP(x, y, solver=:Concorde; optimizer=nothing)
    if solver == :Concorde 
        return solve_TSP_Concorde(x, y)
    elseif solver == :LKH 
        return solve_TSP_LKH(x, y)
    elseif solver == :JuliaExact
        if optimizer == nothing 
            error("An optimizer, such as Gurobi.Optimizer, is required.")
        end
        return solve_TSP_JuliaExact(x, y, optimizer)
    else 
        error("Solver $solver is not available.")
    end
end