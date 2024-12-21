require "cmake"

include "library.lua"

workspace(get_project_name() .. " Workspace") 
	architecture "x64"
	configurations { "Debug", "Release", "Dist" }
	startproject(get_project_name())

include "project.lua"