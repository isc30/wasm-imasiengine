project(Game)
add_executable(Game)

# Helpful
if(DEFINED EMSCRIPTEN)
    set_target_properties(Game PROPERTIES SUFFIX ".html")
endif()

# Dependencies
target_link_libraries(Game PUBLIC calculator)

find_package(SDL2 REQUIRED)
target_link_libraries(Game PUBLIC SDL2::SDL2)

# Includes
target_include_directories(Game
    PUBLIC
        $<INSTALL_INTERFACE:include>
        $<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}/include>
    PRIVATE
        ${CMAKE_CURRENT_SOURCE_DIR}/src
)

# Sources
target_sources(Game
    PRIVATE
        ${CMAKE_CURRENT_LIST_DIR}/src/main.cpp
)

# Copy SDL2 DLL to output folder on Windows
if(NOT DEFINED EMSCRIPTEN AND WIN32)
    foreach(DLL ${SDL2_LIBRARY_DLLS})
        add_custom_command(TARGET Game POST_BUILD COMMAND
            ${CMAKE_COMMAND} -E copy_if_different ${DLL} $<TARGET_FILE_DIR:Game>)
    endforeach()
endif()

if(DEFINED EMSCRIPTEN)
    set(Game_INSTALL_FILES
        ${CMAKE_CURRENT_SOURCE_DIR}/assets/Gaame.html
        ${MAGNUM_EMSCRIPTENAPPLICATION_JS}
        ${MAGNUM_WEBAPPLICATION_CSS})

    foreach(INSTALL_FILE ${Game_INSTALL_FILES})
        add_custom_command(TARGET Game POST_BUILD COMMAND
            ${CMAKE_COMMAND} -E copy_if_different ${INSTALL_FILE} $<TARGET_FILE_DIR:Game>)
    endforeach()

    install(TARGETS Game DESTINATION ${CMAKE_INSTALL_PREFIX})

    install(FILES ${Game_INSTALL_FILES}
        DESTINATION ${CMAKE_INSTALL_PREFIX})

    install(FILES
        ${CMAKE_CURRENT_BINARY_DIR}/Game.js.mem
        ${CMAKE_CURRENT_BINARY_DIR}/Game.wasm
        DESTINATION ${CMAKE_INSTALL_PREFIX} OPTIONAL)
endif()
