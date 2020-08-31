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

    function expr_array(s::String)
        array = Array{Expression}([])

        array
    end

    function Expression(pat::Pattern, parts::String)
        if pat == root::Pattern
            expr = Expression()
            expr.child1 = expr_array(parts)
            expr
        elseif pat == plus::Pattern
            c = parts[1]
            expr = Expression(pat)
            if c == '('
                m = match(r"^\(\s*(.*)\s*\)$",parts)
                try
                    Expression(group::Pattern, m.captures[1]) |> x->push!(expr.child1, x)
                catch
                    println("\"()\" error")
                end
            elseif c == '['
                m = match(r"^\[\s*(.*)\]$",parts)
                try
                    Expression(one_of::Pattern, m.captures[1]) |> x->push!(expr.child1, x)
                catch
                    println("\"[]\" error")
                end
            elseif c == '\"'
                m = match(r"^\"(.*)\"$",parts)
                try
                    Expression(symbol::Pattern, m.captures[1]) |> x->push!(expr.child1, x)
                catch
                    println("\"\" error")
                end
            elseif c == '\\'
                try
                    Expression(escape::Pattern, parts[2]) |> x->push!(expr.child1, x)
                catch
                    println("\"\\\" error")
                end
            elseif c == '.'
                try
                    Expression(everything::Pattern) |> x->push!(expr.child1, x)
                catch
                    println("\".\" error")
                end
            else
                try
                    Expression(rule_name::Pattern, parts) |> x->push!(expr.child1, x)
                catch
                    println("name error")
                end
            end
            expr
        elseif pat == asterisk::Pattern
        elseif pat == question::Pattern
        elseif pat == assign::Pattern
        elseif pat == group::Pattern
        elseif pat == one_of::Pattern
        elseif pat == rule_name::Pattern
        elseif pat == symbol::Pattern
        elseif pat == escape::Pattern
        else
            nothing
        end
    end

    Expression(left::String, right::String) = new(choice::Pattern, expr_array(left), expr_array(right), nothing)

    Expression(pat::Pattern = root::Pattern) = new(pat, Array{Expression}([]), Array{Expression}([]), nothing)
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
