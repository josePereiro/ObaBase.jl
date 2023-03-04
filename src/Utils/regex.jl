# ------------------------------------------------------------------
function _get_match(rmatch::RegexMatch, ksym::Symbol, dflt = nothing) 
    cap = rmatch[ksym]
    return isnothing(cap) ? dflt : string(cap)
end

# ------------------------------------------------------------------
function _match_pos(rm::RegexMatch) 
    i0 = rm.offset
    i1 = i0 + length(rm.match) - 1
    return i0:i1
end

