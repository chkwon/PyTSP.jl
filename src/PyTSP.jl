module PyTSP

# Write your package code here.

using PyCall, Conda

include("tsp_solvers.jl")

export  solve_TSP_Concorde, solve_TSP_LKH, 
        distance_matrix, tour_length, distance_matrix_float

end
