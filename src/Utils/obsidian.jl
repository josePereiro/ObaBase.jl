## ------------------------------------------------------------------
# Ex: obsidian://open?vault=notebook&file=2_notes%2F%40braunsteinCompressedSensingReconstruction2019

export _obsidian_url
function _obsidian_url(vault::String, file::String)
    vault = abspath(vault)
    file = abspath(file)
    
    file = replace(file, vault => "")[2:end] # delete vault path
    file = escapeuri(file)
    vault = escapeuri(basename(vault))

    return string("obsidian://open?", 
        "vault=", vault, "&",
        "file=", file
    )
end

_onsidian_filelink(file) = string("[[", first(splitext(basename(file))), "]]")
