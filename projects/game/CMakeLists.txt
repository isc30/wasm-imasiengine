project(Game)
add_executable(Game)

# Strict Compilation
set_directory_properties(PROPERTIES CORRADE_USE_PEDANTIC_FLAGS ON)

# Dependencies
find_package(Magnum REQUIRED
    GL
    Shaders
    Sdl2Application
    MeshTools
    Primitives
    Trade)

target_link_libraries(Game PRIVATE
    Magnum::Application
    Magnum::GL
    Magnum::Shaders
    Magnum::MeshTools
    Magnum::Primitives
    Magnum::Trade
    Magnum::Magnum)

target_link_libraries(Game PRIVATE ecs)

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
        ${CMAKE_CURRENT_LIST_DIR}/src/BouncingBalls.cpp
        ${CMAKE_CURRENT_LIST_DIR}/src/Systems/SpriteRenderSystem.cpp
)

# Copy SDL2 DLL to output folder on Windows
if(NOT CORRADE_TARGET_EMSCRIPTEN AND WIN32)
    find_package(SDL2 REQUIRED)
    add_custom_command(TARGET Game POST_BUILD COMMAND ${CMAKE_COMMAND} -E copy_if_different ${SDL2_BIN_DIR}/SDL2.dll $<TARGET_FILE_DIR:Game>)
endif()

if(CORRADE_TARGET_EMSCRIPTEN)

    set(GAME_INSTALL_FILES
        ${CMAKE_CURRENT_SOURCE_DIR}/assets/Game.html
        ${MAGNUM_EMSCRIPTENAPPLICATION_JS}
        ${MAGNUM_WEBAPPLICATION_CSS})

    foreach(INSTALL_FILE ${GAME_INSTALL_FILES})
        add_custom_command(TARGET Game POST_BUILD COMMAND
            ${CMAKE_COMMAND} -E copy_if_different ${INSTALL_FILE} $<TARGET_FILE_DIR:Game>)
    endforeach()

    install(TARGETS Game DESTINATION ${CMAKE_INSTALL_PREFIX})

    install(FILES ${GAME_INSTALL_FILES}
        DESTINATION ${CMAKE_INSTALL_PREFIX})

    install(FILES
        ${CMAKE_CURRENT_BINARY_DIR}/Game.js.mem
        ${CMAKE_CURRENT_BINARY_DIR}/Game.wasm
        DESTINATION ${CMAKE_INSTALL_PREFIX} OPTIONAL)
endif()
