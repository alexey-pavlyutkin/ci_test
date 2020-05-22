cmake_minimum_required( VERSION 3.15 FATAL_ERROR )

file( GLOB test_sources *.cpp )

add_executable( regression ${test_sources} )

if ( ${CMAKE_CXX_COMPILER_ID} STREQUAL "MSVC" )
  target_compile_options(${TARGET_NAME} PRIVATE /W4 /WX)
else()
  target_compile_options(${TARGET_NAME} PRIVATE -Wall -Wextra -pedantic -Werror)
endif()

if ( ${CMAKE_CXX_COMPILER_ID} STREQUAL "GNU" )
    message( STATUS "SANITIZE=${SANITIZE}" )
    foreach( opt ${SANITIZE} )
        message( STATUS "Applying -fsanitize=${opt}" )
        target_compile_options( regression PRIVATE "-fsanitize=${opt}" )
    endforeach()
endif()

target_link_libraries( regression PRIVATE gtest gtest_main )

gtest_add_tests( TARGET regression AUTO )
