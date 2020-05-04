cmake_minimum_required( VERSION 3.15 FATAL_ERROR )

project( kvs LANGUAGES CXX )

set( CMAKE_MODULE_PATH ${PROJECT_SOURCE_DIR}/cmake )

get_property( isMultiConfig GLOBAL PROPERTY GENERATOR_IS_MULTI_CONFIG )
if ( isMultiConfig )
    set_property( GLOBAL PROPERTY USE_FOLDERS ON )
endif()

option( BUILD_KVS_TESTS   "Build regression tests" ON )
option( BUILD_KVS_STRESS  "Build stress tests"     ON )

add_subdirectory( src )
add_subdirectory( test )
