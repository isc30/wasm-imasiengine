project(hello_world)
add_executable(hello_world)

# Dependencies
target_link_libraries(hello_world PUBLIC calculator)

find_package(SDL2 REQUIRED)
target_link_libraries(hello_world PUBLIC
    SDL2::SDL2
    SDL2::SDL2main)

# Includes
target_include_directories(hello_world
    PUBLIC
        $<INSTALL_INTERFACE:include>
        $<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}/include>
    PRIVATE
        ${CMAKE_CURRENT_SOURCE_DIR}/src
)

# Sources
target_sources(hello_world
    PRIVATE
        ${CMAKE_CURRENT_LIST_DIR}/src/main.cpp
)

# Copy SDL2 DLL to output folder on Windows
if(NOT DEFINED EMSCRIPTEN AND WIN32)
    foreach(DLL ${SDL2_DLL})
        add_custom_command(TARGET hello_world POST_BUILD COMMAND
            ${CMAKE_COMMAND} -E copy_if_different ${DLL} $<TARGET_FILE_DIR:hello_world>)
    endforeach()
endif()
