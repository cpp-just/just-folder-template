function get_project_name()
    local file = io.open("metadata.json", "r")
    local content = file:read("*all")
    file:close()
    
    local project_name = content:match('"ProjectName"%s*:%s*"(.-)"')
    return project_name
end

function get_source_files()
    local extensions = {}
    for line in io.lines("file_extensions") do
        table.insert(extensions, "../src/**." .. line)
    end
    return extensions
end

function get_lib_dirs()
    local lib_paths = {}
    local p = io.popen('[ -d packages ] && ls -1 packages')
    for folder in p:lines() do
        local lib_path = "packages/" .. folder .. "/lib"
        table.insert(lib_paths, lib_path)
    end
    p:close()
    return lib_paths
end

function get_links()
    local files = {}
    for _, lib_path in ipairs(get_lib_dirs()) do
        local p = io.popen('ls -1 ' .. lib_path)
        for file in p:lines() do
            local filename = file:match("(.+)%..+")
            table.insert(files, filename)
        end
        p:close()
    end
    return files
end

return {
    get_project_name = get_project_name,
    get_source_files = get_source_files,
    get_lib_dirs = get_lib_dirs,
    get_links = get_links
}