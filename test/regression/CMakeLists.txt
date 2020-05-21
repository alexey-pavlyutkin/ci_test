cmake_minimum_required( VERSION 3.15 FATAL_ERROR )

file( GLOB test_sources *.cpp )

add_executable( regression ${test_sources} )

if ( NOT ${SANITIZE} STREQUAL "" )
    message( STATUS "Applying -fsanitize=${SANITIZE}" )
    target_compile_options( regression PRIVATE "-fsanitize=${SANITIZE}" )
endif()

#target_link_libraries( regression PRIVATE jb )
target_link_libraries( regression PRIVATE gtest gtest_main )

gtest_add_tests( TARGET regression AUTO )
