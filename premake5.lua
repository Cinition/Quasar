vulkan_sdk = os.getenv("VULKAN_SDK")
glfw_folder = "Dependencies/glfw/"

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

defines {
    -- VULKAN
    "VULKAN_HPP_NO_NODISCARD_WARNINGS",
    "VULKAN_HPP_NO_EXCEPTIONS",
    "VK_USE_PLATFORM_WIN32_KHR",        
}

workspace "Quasar"
    architecture "x86_64"
    configurations { "Debug","Release" }
    startproject "Quasar"

    project "Quasar"
        kind "WindowedApp"
        location ( "Bin/Quasar" )
        targetdir( "Build/Quasar/%{cfg.buildcfg}" )
        
        files {
            "Src/**.h",
            "Src/**.cpp",
            -- VULKAN
            "%{vulkan_sdk}/Source/SPIRV-Reflect/*.h",
        }

        links {
            "GLFW",
            "%{vulkan_sdk}/Lib/vulkan-1.lib",
        }

        includedirs {
            glfw_folder.."include/",
            -- VULKAN
            "%{vulkan_sdk}/Include",
            "%{vulkan_sdk}/Source",
        }

group "Dependencies"

    project "GLFW"
        kind "StaticLib"

        location ( "Bin/GLFW" )
        targetdir( "Build/GLFW/%{cfg.buildcfg}" )

        files {
            glfw_folder.."include/GLFW/glfw3.h",
            glfw_folder.."include/GLFW/glfw3native.h",
            glfw_folder.."src/glfw_config.h",
            glfw_folder.."src/context.c",
            glfw_folder.."src/init.c",
            glfw_folder.."src/input.c",
            glfw_folder.."src/monitor.c",

            glfw_folder.."src/null_init.c",
            glfw_folder.."src/null_joystick.c",
            glfw_folder.."src/null_monitor.c",
            glfw_folder.."src/null_window.c",

            glfw_folder.."src/platform.c",
            glfw_folder.."src/vulkan.c",
            glfw_folder.."src/window.c",
        }

        filter "system:windows"
            files {
                glfw_folder.."src/win32_init.c",
                glfw_folder.."src/win32_joystick.c",
                glfw_folder.."src/win32_module.c",
                glfw_folder.."src/win32_monitor.c",
                glfw_folder.."src/win32_time.c",
                glfw_folder.."src/win32_thread.c",
                glfw_folder.."src/win32_window.c",
                glfw_folder.."src/wgl_context.c",
                glfw_folder.."src/egl_context.c",
                glfw_folder.."src/osmesa_context.c"
            }

            defines { 
                "_GLFW_WIN32",
                "_CRT_SECURE_NO_WARNINGS"
            }

group ""