@enum Pattern begin
    root
    rule_name
    choice          #/
    symbol          #""
    group           #()
    one_of          #[]
    assign          #{}
    plus            #+
    asterisk        #*
    question        #?
    everything      #.
    minus           #-
    escape          #\
    not             #^
end

mutable struct Expression
    pattern::Pattern
    child1::Array{Expression}
    child2::Array{Expression}
    option::Any

    function Expression(pat::Pattern, parts::String)
        if pat == root::Pattern
            c1 = Array{Expression}([])
            c2 = Array{Expression}([])

        else
            nothing
        end
    end

    function Expression(parts::String)

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
            new(name, Expression(root::Pattern, expr))
        else
            nothing
        end
    end
end

struct PEG
    rules::Array{Rule}
    PEG() = new(Array{Rule}([]))
end
