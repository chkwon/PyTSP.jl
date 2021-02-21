# PyTSP

[![Build Status](https://github.com/chkwon/PyTSP.jl/workflows/CI/badge.svg?branch=master)](https://github.com/chkwon/PyTSP.jl/actions?query=workflow%3ACI)
[![codecov](https://codecov.io/gh/chkwon/PyTSP.jl/branch/master/graph/badge.svg)](https://codecov.io/gh/chkwon/PyTSP.jl)


This Julia package provides access to the [Concorde TSP Solver](http://www.math.uwaterloo.ca/tsp/concorde/index.html) and the [Lin-Kernighan-Held (LKH) solver](http://webhotel4.ruc.dk/~keld/research/LKH/) via [PyConcorde](https://github.com/jvkersch/pyconcorde) and [elkai](https://github.com/filipArena/elkai), respectively. 

As both PyConcorde and elkai are Python libraries, this package merely provides a Julia wrapper using PyCall. 

In Windows, this package does not work. Consider using Windows Subsystem for Linux (WSL).

## License

MIT License only applies to PyTSP.jl. The Python parts, PyConcorde and elkai, come in difference licenses. The underlying solvers, thee Conrcorde TSP Solver and LKH, require special licenses for commercial usage. Please check their websites.

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
