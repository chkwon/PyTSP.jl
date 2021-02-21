import PyCall, Conda

println("building PyTSP...")


Conda.add("git")
Conda.add("pip")
Conda.add("cython")
Conda.add("numpy")

const pip = joinpath(Conda.BINDIR, "pip")

# Install pyconcorde (The Concorde TSP Solver + QSOpt LP Library)
# https://github.com/jvkersch/pyconcorde
run(`$pip install git+git://github.com/jvkersch/pyconcorde.git`)

# Install elkai (The LKH Solver)
# https://github.com/filipArena/elkai
run(`$pip install elkai`)
