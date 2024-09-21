## ------------------------------------------------------------------
export _canonicalize
_canonicalize(t::Real, T = Second) = canonicalize(T(round(t)))
_canonicalize(p) = canonicalize(p)

_displaysize(io::IO) = displaysize(io)
_displaysize(io) = displaysize(stdout)

## ------------------------------------------------------------------
const INFO_COLOR = :green
const KEY_COLOR = :blue
const ERROR_COLOR = :red
const WARN_COLOR = :yellow
const SOFT_COLOR = 8

export _info
function _info(io::T, msg::String, sep, kwargs) where {T<:IO}

    ioh, iow = _displaysize(io)

    println(io)
    !isempty(sep) && println(io, sep^max(30, iow - 10))
    printstyled(io, msg; bold = true, color = INFO_COLOR)
    println(io)
    for (k, val) in kwargs
        printstyled(io, k, ": "; bold = false, color = KEY_COLOR)
        printstyled(io, val; bold = false, color = SOFT_COLOR)
        println(io)
    end
end
_info(io::T, msg::String, sep; kwargs...) where {T<:IO} = _info(io, msg, sep, kwargs)
_info(msg::String, sep, kwargs) = _info(stdout, msg, sep, kwargs)
_info(msg::String, sep; kwargs...) = _info(stdout, msg, sep, kwargs)

export _warn
function _warn(io::T, msg::String, sep, kwargs)  where {T<:IO} 

    ioh, iow = _displaysize(io)

    println(io)
    !isempty(sep) && println(io, sep^max(30, iow - 10))
    printstyled(io, msg; bold = true, color = WARN_COLOR)
    println(io)
    for (k, val) in kwargs
        printstyled(io, k, ": "; bold = false, color = KEY_COLOR)
        printstyled(io, val; bold = false, color = SOFT_COLOR)
        println(io)
    end
end
_warn(io::IO, msg::String, sep; kwargs...) = _warn(io, msg, sep, kwargs)
_warn(msg::String, sep, kwargs) = _warn(stdout, msg, sep, kwargs)
_warn(msg::String, sep; kwargs...) = _warn(stdout, msg, sep, kwargs)

export _error
function _error(io::T, msg::String, err, sep; kwargs...) where {T<:IO} 
    
    ioh, iow = _displaysize(io)

    println(io)
    !isempty(sep) && printstyled(io, sep^max(30, iow - 10); bold = true, color = ERROR_COLOR)
    println(io)
    printstyled(io, msg; bold = true, color = ERROR_COLOR)
    println(io)
    for (k, val) in kwargs
        printstyled(io, k, ": "; bold = false, color = KEY_COLOR)
        printstyled(io, val; bold = false, color = SOFT_COLOR)
        println(io)
    end
    println(io)
    errstr = sprint(showerror, err, catch_backtrace())
    printstyled(io, errstr; bold = false, color = SOFT_COLOR)
    println(io)
end
_error(msg::String, err, sep; kwargs...) = _error(stdout, msg, err, sep; kwargs...)

export _tee
function _tee(printfun::Function, ios::Vector, args...; kwargs...)
    for io in ios
        if io isa AbstractString
            open(_io -> printfun(_io, args...; kwargs...), io, "w")
            else; printfun(io, args...; kwargs...)
        end
    end
end