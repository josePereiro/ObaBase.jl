# ------------------------------------------------------------------
function _exportall(filter::Function, mod::Module)
    for sym in names(mod; all = true, imported = true)
        filter(sym) == true || continue
        @eval mod export $(sym)
    end
end

macro _exportall_non_underscore()
    return quote
        _exportall($(__module__)) do sym
            sym == :eval && return false
            sym == :include && return false
            startswith(string(sym), r"@?[^_#]") && return true
            return false
        end
    end
end
