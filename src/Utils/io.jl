## ------------------------------------------------------------------
export capture_io
function capture_io(f::Function; onerr = (err) -> nothing)  
    outfile = tempname()
    mkpath(dirname(outfile))
    rm(outfile; force = true)
    redirect_stdio(; stdout = outfile, stderr = outfile) do
        try
            f()
        catch err
            println("\n", sprint(showerror, err, catch_backtrace()))
            onerr(err)
        end
    end
    out = ""
    try
        out = read(outfile, String)
    finally
        rm(outfile; force = true)
    end
    return out
end