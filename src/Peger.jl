module Peger

include("rule.jl")

function readPEG(filename::String)
    texts = open(filename,"r") |> readlines
    filter!(!isempty, texts)
    p = PEG()
    for text = texts
        rule = Rule(text)
        if rule == nothing
            println("Error")
        else
            push!(p.rules,rule)
        end
    end
    p
end

end
