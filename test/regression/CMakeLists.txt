cmake_minimum_required( VERSION 3.15 FATAL_ERROR )

enable_testing()

file( GLOB test_sources *.cpp )

add_executable( regression ${test_sources} )
#target_link_libraries( regression PRIVATE jb )
target_link_libraries( regression PRIVATE gtest gtest_main )

gtest_add_tests( TARGET regression AUTO )

add_test( NAME regression COMMAND regression )
