include "library.lua"

local outputdir = "%{cfg.buildcfg}-%{cfg.system}-%{cfg.architecture}"

project(get_project_name())
	kind "ConsoleApp"
	language "C++"
	cppdialect "C++17"

	targetdir ("../bin/" .. outputdir .. "/%{prj.name}")
	objdir ("../bin-int/" .. outputdir .. "/%{prj.name}")

	files(get_source_files())
	libdirs(get_lib_dirs())
	links(get_links())

	filter "configurations:Debug"
		runtime "Debug"
		symbols "On"

	filter "configurations:Release"
		runtime "Release"
		optimize "On"
		symbols "On"

	filter "configurations:Dist"
		runtime "Release"
		optimize "On"
		symbols "Off"
