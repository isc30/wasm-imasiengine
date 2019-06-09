set(gtest_force_shared_crt ON CACHE BOOL "" FORCE)

#SET(GTEST_LANG_CXX11 1)

if(CMAKE_VERSION VERSION_LESS 3.11)
    set(UPDATE_DISCONNECTED_IF_AVAILABLE "UPDATE_DISCONNECTED 1")

    download_project(PROJ                googletest
		     GIT_REPOSITORY      https://github.com/google/googletest.git
		     GIT_TAG             release-1.8.1
		     UPDATE_DISCONNECTED 1
		     QUIET
    )

    # CMake warning suppression will not be needed in version 1.9
    set(CMAKE_SUPPRESS_DEVELOPER_WARNINGS 1 CACHE BOOL "")
    add_subdirectory(${googletest_SOURCE_DIR} ${googletest_SOURCE_DIR} EXCLUDE_FROM_ALL)
    unset(CMAKE_SUPPRESS_DEVELOPER_WARNINGS)
else()
    include(FetchContent)
    FetchContent_Declare(googletest
        GIT_REPOSITORY      https://github.com/google/googletest.git
        GIT_TAG             release-1.8.1)
    FetchContent_GetProperties(googletest)
    if(NOT googletest_POPULATED)
        FetchContent_Populate(googletest)
        set(CMAKE_SUPPRESS_DEVELOPER_WARNINGS 1 CACHE BOOL "")
        add_subdirectory(${googletest_SOURCE_DIR} ${googletest_BINARY_DIR} EXCLUDE_FROM_ALL)
        unset(CMAKE_SUPPRESS_DEVELOPER_WARNINGS)
    endif()
endif()


if(CMAKE_CONFIGURATION_TYPES)
    add_custom_target(check COMMAND ${CMAKE_CTEST_COMMAND} 
        --force-new-ctest-process --output-on-failure 
        --build-config "$<CONFIGURATION>")
else()
    add_custom_target(check COMMAND ${CMAKE_CTEST_COMMAND} 
        --force-new-ctest-process --output-on-failure)
endif()

#include_directories(${gtest_SOURCE_DIR}/include)

# More modern way to do the last line, less messy but needs newish CMake:
#target_include_directories(gtest INTERFACE ${gtest_SOURCE_DIR}/include)

if(GOOGLE_TEST_INDIVIDUAL)
    if(NOT CMAKE_VERSION VERSION_LESS 3.9)
        include(GoogleTest)
    else()
        set(GOOGLE_TEST_INDIVIDUAL OFF)
    endif()
endif()

# Target must already exist
macro(add_gtest TESTTARGET)
    target_link_libraries(${TESTTARGET} PUBLIC gtest gmock gtest_main)
    
    if(GOOGLE_TEST_INDIVIDUAL)
        if(CMAKE_VERSION VERSION_LESS 3.10)
            gtest_add_tests(TARGET ${TESTTARGET}
                            TEST_PREFIX "${TESTTARGET}."
                            TEST_LIST TmpTestList)
        else()
            gtest_discover_tests(${TESTTARGET}
                TEST_PREFIX "${TESTTARGET}.")
        endif()
    else()
        add_test(
            NAME ${TESTTARGET}
            COMMAND $<TARGET_FILE:${TESTTARGET}>)
    endif()

endmacro()

mark_as_advanced(
    gmock_build_tests
    gtest_build_samples
    gtest_build_tests
    gtest_disable_pthreads
    gtest_force_shared_crt
    gtest_hide_internal_symbols
    BUILD_GMOCK
    BUILD_GTEST
)
