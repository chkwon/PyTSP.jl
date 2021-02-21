import PyCall

# , Conda

# Conda.add("git")
# Conda.add("pip")
# Conda.add("cython")
# Conda.add("numpy")

# const pip = joinpath(Conda.BINDIR, "pip")

proxy_arg = String[]
if haskey(ENV, "http_proxy")
    push!(proxy_arg, "--proxy")
    push!(proxy_arg, ENV["http_proxy"])
end

pip = `$(PyCall.python) -m pip`
run(`$pip install --user --upgrade pip setuptools`)
run(`$pip install --user cython numpy`)

# Install pyconcorde (The Concorde TSP Solver + QSOpt LP Library)
# https://github.com/jvkersch/pyconcorde
run(`$pip install git+git://github.com/jvkersch/pyconcorde.git`)

# Install elkai (The LKH Solver)
# https://github.com/filipArena/elkai
run(`$pip install elkai`)
