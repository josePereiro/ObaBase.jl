# ------------------------------------------------------------------
export foreach_file
function foreach_file(f::Function, vault, ext = ".md"; 
        keepout = [".obsidian", ".git"]
    )
    walkdown(vault; keepout) do path
        !endswith(path, ext) && return
        f(path)
    end
end

# ------------------------------------------------------------------
export findall_files
function findall_files(vault::AbstractString, ext = ".md";
        sortby = mtime, sortrev = false, keepout = [".obsidian", ".git"]
    )
    files = filterdown((path) -> endswith(path, ext), vault; keepout)
    sort!(files; by = sortby, rev = sortrev)
    return files
end

## ------------------------------------------------------------------
export find_file
function find_file(vault, name; keepout = [".obsidian", ".git"])
    path = ""
    walkdown(vault; keepout) do path_
        if basename(path_) == name
            path = path_
            return true
        end
        return false
    end
    return path
end


