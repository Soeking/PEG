module Peger

include("rule.jl")

function readPEG(filename::String)
    texts = open(filename,"r") |> readlines
    filter!(x -> length(x) > 0, texts)
    foreach(println, texts)
end

end