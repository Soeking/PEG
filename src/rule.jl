mutable struct Expression
    parts::Array{Any}
end

mutable struct Rule
    name::String
    expressions::Array{Expression}
end

struct PEG
    rules::Array{Rule}
    PEG() = new(Array{Rule}([]))
end
