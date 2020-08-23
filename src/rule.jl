mutable struct Expression
    parts::Array{Any}
end

mutable struct Rule
    name::String
    expressions::Array{Expression}

    function Rule(line::String)
        check = match(r"\w+\s*<-.*$", line)
        len = check.match
        if length(line) == length(check)
            m = match(r"^(\w+)\s*<-\s*(.*)$", line)
            (name, expr) = m.captures
            new(name, Expression(expr))
        else
            nothing
        end
    end
end

struct PEG
    rules::Array{Rule}
    PEG() = new(Array{Rule}([]))
end
