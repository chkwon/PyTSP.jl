using PyCall

PACKAGES = ["cython", "numpy", "elkai", "git+git://github.com/jvkersch/pyconcorde.git"]

try
    pyimport("pip")
catch
    get_pip = joinpath(dirname(@__FILE__), "get-pip.py")
    download("https://bootstrap.pypa.io/get-pip.py", get_pip)
    run(`$(PyCall.python) $get_pip --user`)
end

pip = pyimport("pip")
args = String[]
if haskey(ENV, "http_proxy")
    push!(args, "--proxy")
    push!(args, ENV["http_proxy"])
end
push!(args, "install")
push!(args, "--user")
append!(args, PACKAGES)
pip.main(args)