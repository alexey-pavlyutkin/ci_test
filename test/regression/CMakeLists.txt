cmake_minimum_required( VERSION 3.15 FATAL_ERROR )

file( GLOB test_sources *.cpp )

add_executable( regression ${test_sources} )

if ( ${CMAKE_CXX_COMPILER_ID} STREQUAL "GNU" )
    foreach( sanitize_opt IN ${SANITIZE} )
        message( STATUS "Applying -fsanitize=${sanitize_opt}" )
        target_compile_options( regression PRIVATE "-fsanitize=${SANITIZE}" )
    endforeach()
endif()

target_link_libraries( regression PRIVATE gtest gtest_main )

gtest_add_tests( TARGET regression AUTO )
