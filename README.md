# Concorde.jl
An interface to Conrcorde TSP solver via [pyconcorde](https://github.com/jvkersch/pyconcorde).


## Install
```julia
import Pkg
Pkg.add("PyCall")
Pkg.add("Conda")

import Conda
Conda.add("git")
Conda.add("pip")
Conda.add("cython")
Conda.add("numpy")

pip = joinpath(Conda.BINDIR, "pip")

run(`$pip install git+git://github.com/jvkersch/pyconcorde.git`)
```


## Usage
```julia
using PyCall 
Concorde = pyimport("concorde.tsp")

n_cities = 100
x = rand(n_cities)
y = rand(n_cities)

# Instantiate solver
solver = Concorde.TSPSolver.from_data(x, y, norm="GEOM")

# Find tour
tour_data = solver.solve()
@assert tour_data[3] #tour_data.success

# +1 for converting 0-index to 1-index
tour = tour_data[1] .+ 1  # tour_data.tour 
println(tour)
```

Plotting the solution:
```julia
using PyPlot

fig = figure() 
scatter(x, y)
# for i, txt in enumerate(range(n_cities)):
#     plt.annotate(txt, (x[i], y[i]))


for i in 1:n_cities-1
    plot([x[tour[i]], x[tour[i+1]]], [y[tour[i]], y[tour[i+1]]])
end
plot([x[tour[end]], x[tour[1]]], [y[tour[end]], y[tour[1]]])

savefig("tsp.png")
close(fig)
```

