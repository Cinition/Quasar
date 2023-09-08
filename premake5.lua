cppdialect "C++17"
language "C++"
staticruntime "off"

filter "configurations:Debug"
runtime "Debug"
symbols "on"
defines { "DEBUG" }

filter "configurations:Release"
runtime "Release"
optimize "speed"
symbols "off"
defines { "RELEASE" }

workspace "Quasar"
    architecture "x86_64"
    startproject "Quasar"

    configurations {
        "Debug",
        "Release"
    }
    
    project "Quasar"
        kind "ConsoleApp"
            
        location  ( "Bin" )
        targetdir ( "Build/%{cfg.buildcfg}" )
        

        files {
            "Src/**.h",
            "Src/**.cpp"
        }