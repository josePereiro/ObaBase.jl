## ------------------------------------------------------------------
export _canonicalize
_canonicalize(t::Real, T = Second) = canonicalize(T(round(t)))
_canonicalize(p) = canonicalize(p)

## ------------------------------------------------------------------
const INFO_COLOR = :green
const KEY_COLOR = :blue
const ERROR_COLOR = :red
const WARN_COLOR = :yellow
const SOFT_COLOR = 8

export _info
function _info(io::IO, msg::String, sep, kwargs)

    ioh, iow = displaysize(io)

    println()
    !isempty(sep) && println(sep^max(30, iow - 10))
    printstyled(msg; bold = true, color = INFO_COLOR)
    println()
    for (k, val) in kwargs
        printstyled(k, ": "; bold = false, color = KEY_COLOR)
        printstyled(val; bold = false, color = SOFT_COLOR)
        println()
    end
end
_info(io::IO, msg::String, sep; kwargs...) = _info(io, msg, sep, kwargs)
_info(msg::String, sep, kwargs) = _info(stdout, msg, sep, kwargs)
_info(msg::String, sep; kwargs...) = _info(stdout, msg, sep, kwargs)

export _warn
function _warn(io::IO, msg::String, sep, kwargs)

    ioh, iow = displaysize(io)

    println()
    !isempty(sep) && println(sep^max(30, iow - 10))
    printstyled(msg; bold = true, color = WARN_COLOR)
    println()
    for (k, val) in kwargs
        printstyled(k, ": "; bold = false, color = KEY_COLOR)
        printstyled(val; bold = false, color = SOFT_COLOR)
        println()
    end
end
_warn(io::IO, msg::String, sep; kwargs...) = _warn(io, msg, sep, kwargs)
_warn(msg::String, sep, kwargs) = _warn(stdout, msg, sep, kwargs)
_warn(msg::String, sep; kwargs...) = _warn(stdout, msg, sep, kwargs)

export _error
function _error(io::IO, msg::String, err, sep; kwargs...)
    ioh, iow = displaysize(io)

    println()
    printstyled(sep^max(30, iow - 10); bold = true, color = ERROR_COLOR)
    println()
    printstyled(msg; bold = true, color = ERROR_COLOR)
    println()
    for (k, val) in kwargs
        printstyled(k, ": "; bold = false, color = KEY_COLOR)
        printstyled(val; bold = false, color = SOFT_COLOR)
        println()
    end
    println()
    errstr = sprint(showerror, err, catch_backtrace())
    printstyled(errstr; bold = false, color = SOFT_COLOR)
    println()
end
_error(msg::String, err, sep; kwargs...) = _error(stdout, msg, err, sep; kwargs...)
