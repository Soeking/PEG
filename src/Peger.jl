module Peger

include("rule.jl")

function readPEG(filename::String)
    texts = open(filename,"r") |> readlines
    filter!(!isempty, texts)
    PEG()
end

end
