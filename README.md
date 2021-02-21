# PyTSP

This Julia package provides access to the [Concorde TSP Solver](http://www.math.uwaterloo.ca/tsp/concorde/index.html) and the [Lin-Kernighan-Held (LKH) solver](http://webhotel4.ruc.dk/~keld/research/LKH/) via [PyConcorde](https://github.com/jvkersch/pyconcorde) and [elkai](https://github.com/filipArena/elkai), respectively. 

As both PyConcorde and elkai are Python libraries, this package merely provides a Julia wrapper using PyCall.

## Installation

`] add https://github.com/chkwon/PyTSP.jl`

## Usage

### Concorde

Concorde uses integers for distance calculation. Your `(x, y)` coordinate inputs should be scaled appropriately.

```julia
using PyTSP
n_cities = 20
factor = 1e5
x = rand(n_cities) .* factor
y = rand(n_cities) .* factor

# The Concorde TSL Solver via pyconcorde
tour, len = solve_TSP_Concorde(x, y, norm="EUC_2D")
```


```julia
([1, 2, 19, 13, 18, 11, 4, 14, 7, 6, 15, 10, 8, 16, 20, 5, 9, 3, 12, 17], 389803)
```

### LKH

Since LKH also benefits from integer inputs, this package uses intger as default type.

```julia
using PyTSP
n_cities = 20
factor = 1e5
x = rand(n_cities) .* factor
y = rand(n_cities) .* factor

# The LKH  heuristic solver via elkai
tour_LKH, length_LKH = solve_TSP_LKH(x, y)
```

```julia
([1, 2, 19, 13, 18, 11, 4, 14, 7, 6, 15, 10, 8, 16, 20, 5, 9, 3, 12, 17], 389803)
```


You can also input a distance matrix, either `Matrix{Int}` or `Matrix{Float64}`.

```julia
using PyTSP
n_cities = 20
factor = 1e5
x = rand(n_cities) .* factor
y = rand(n_cities) .* factor

M = distance_matrix(x, y) # returns a rounded Matrix{Int}
tour_LKH, length_LKH = solve_TSP_LKH(M)

N = distance_matrix_float(x, y) # returns a Matrix{Float64}
tour_LKH, length_LKH = solve_TSP_LKH(N)
```