@enum Pattern begin
    rule_name
    choice          #/
    symbol          #""
    group           #()
    one_of          #[]
    plus            #+
    asterisk        #*
    question        #?
    everything      #.
    minus           #-
    escape          #\
    not             #^
end

mutable struct PartsType
    pat::Pattern
    child1::Array{PartsType}
    child2::Array{PartsType}
end

mutable struct Expression
    parts::Array{Any}

    function Expression(part::String)

    end
end

mutable struct Rule
    name::String
    expressions::Expression

    function Rule(line::String)
        check = match(r"^\s*\w+\s*<-.*$", line)
        len = check.match
        if length(line) == length(len)
            m = match(r"(\w+)\s*<-\s*(.*)", line)
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
