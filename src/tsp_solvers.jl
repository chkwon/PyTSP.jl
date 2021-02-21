function distance_matrix_float(x, y)
    @assert length(x) == length(y)
    n = length(x)
    M = zeros(n, n)
    for i in 1:n 
        for j in i+1:n 
            if i != j
                M[i, j] = sqrt( (x[i]-x[j])^2 + (y[i]-y[j])^2 )
                M[j, i] = M[i, j]
            end 
        end 
    end 
    return M
end

function distance_matrix(x, y)
    M = distance_matrix_float(x, y)
    return Int.(round.(M))
end

function tour_length(tour, M::Matrix{T}) where T
    sum = zero(T) 
    for i in 1:length(tour) 
        if i < length(tour)
            sum += M[tour[i], tour[i+1]]
        else 
            sum += M[tour[i], tour[1]]
        end
    end
    return sum
end

# function tour_length(tour, x, y) 
#     M = distance_matrix(x, y)
#     return tour_length(tour, M)
# end 

function solve_TSP_Concorde(x, y; norm="EUC_2D",)
    Concorde = pyimport("concorde.tsp")
    solver = Concorde.TSPSolver.from_data(x, y, norm)
    tour_data = solver.solve()
    tour_concorde = tour_data[1] .+ 1  # 0-index -> 1-index
    # length_concorde = tour_length(tour_concorde, x, y) 
    length_concorde = Int(tour_data[2])
    return tour_concorde, length_concorde
end

function solve_TSP_LKH(M::Matrix{T}) where T
    Elkai = pyimport("elkai")
    if T == Int
        tour_LKH = Elkai.solve_int_matrix(M) .+ 1 #adding 1 for indexing
    else
        tour_LKH = Elkai.solve_float_matrix(M) .+ 1 #adding 1 for indexing
    end
    length_LKH = tour_length(tour_LKH, M)
    return tour_LKH, length_LKH
end

function solve_TSP_LKH(x, y)
    M = distance_matrix(x, y)
    return solve_TSP_LKH(M)
end
