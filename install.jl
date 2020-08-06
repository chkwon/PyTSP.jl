import Pkg 
Pkg.add("PyCall")
Pkg.add("Conda") 

import Conda
Conda.add("git")
Conda.add("pip")
Conda.add("cython")
Conda.add("numpy")

pip = joinpath(Conda.BINDIR, "pip")

# Install pyconcorde (The Concorde TSP Solver + QSOpt LP Library)
# https://github.com/jvkersch/pyconcorde
run(`$pip install git+git://github.com/jvkersch/pyconcorde.git`)

# Install elkai (The LKH Solver)
# https://github.com/filipArena/elkai
run(`$pip install elkai`)

# Install TravelingSalesmanExact.jl
# Only to check pyconcorde solution (slower than concorde)
Pkg.add("TravelingSalesmanExact")
Pkg.add("GLPK")
