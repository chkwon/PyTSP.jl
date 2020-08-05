function construct_distance_matrix(x, y)
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

function tour_length(tour, x, y) 
    M = construct_distance_matrix(x, y)
    return tour_length(tour, M)
end 

function tour_length(tour, M) 
    sum = 0 
    for i in 1:length(tour) 
        if i < length(tour)
            sum += M[tour[i], tour[i+1]]
        else 
            sum += M[tour[i], tour[1]]
        end
    end
    return sum
end