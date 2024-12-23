function get_project_name()
    local file = io.open("metadata.json", "r")
    local content = file:read("*all")
    file:close()
    
    local project_name = content:match('"ProjectName"%s*:%s*"(.-)"')
    return project_name
end

function read_file_extensions()
    local extensions = {}
    for line in io.lines("file_extensions") do
        table.insert(extensions, "../src/**." .. line)
    end
    return extensions
end

function get_package_lib_paths()
    local lib_paths = {}
    for folder in lfs.dir("packages") do
        if folder ~= "." and folder ~= ".." then
            local lib_path = "packages/" .. folder .. "/lib"
            table.insert(lib_paths, lib_path)
        end
    end
    return lib_paths
end

function get_links()
    local files = {}
    for _, lib_path in ipairs(get_package_lib_paths()) do
        for file in lfs.dir(lib_path) do
            if file ~= "." and file ~= ".." then
                local filename = file:match("(.+)%..+")
                table.insert(files, filename)
            end
        end
    end
    return files
end

return {
    get_project_name = get_project_name,
    read_file_extensions = read_file_extensions,
    get_package_lib_paths = get_package_lib_paths,
    get_links = get_links
}