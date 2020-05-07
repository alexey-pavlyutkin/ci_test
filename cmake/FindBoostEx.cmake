cmake_minimum_required( VERSION 3.13 )

#
# define path for Boost as external project
#
set( external_dir ${PROJECT_SOURCE_DIR}/external )
set( boost_dir ${external_dir}/boost )

#
# provide hints for FindBoost
#
set( BOOST_INCLUDEDIR ${boost_dir} )
#set( BOOST_LIBRARYDIR ${boost_dir}/stage/lib )

#
# try find Boost 1.67+
#
cmake_policy( SET CMP0074 NEW )
find_package( boost 1.67.0 )

if ( Boost_FOUND AND Boost_LIB_VERSION STRGREATER_EQUAL "1.67.0" )

    #
    # Boost found, Boost_INCLUDE_DIRS and Boost_LIBRARY_DIRS variables are defined
    #

else()

    #
    # make sure ./externals folder exists and does not contain boost folder
    #
    file( MAKE_DIRECTORY ${external_dir} )
    file( REMOVE_RECURSE ${boost_dir} )

    #
    # gonna use Git to download Boost from Github
    #
    find_package( Git )
    if ( NOT Git_FOUND )
        message( FATAL_ERROR "Unable to locate Git package!" )
    endif()

    #
    # download Boost
    #
    execute_process(
        COMMAND ${GIT_EXECUTABLE} clone --recurse-submodules https://github.com/boostorg/boost
        WORKING_DIRECTORY ${external_dir}
        TIMEOUT 14400
        RESULT_VARIABLE git_result
    )

    if ( NOT git_result EQUAL 0 )
        message( FATAL_ERROR "Unable to download Boost library!" )
    endif()

    #
    # define bootstrap and build commands
    #
    if ( WIN32 )
        set( boost_bootstrap "bootstrap.bat" )
    elseif ( UNIX )
        set( boost_bootstrap "bootstrap.sh" )
    else()
        message( FATAL_ERROR "Dunno how to build Boost library!" )
    endif()

    #
    # bootstrap Boost
    #
    execute_process(
        COMMAND ${boost_bootstrap}
        WORKING_DIRECTORY ${boost_dir}
        RESULT_VARIABLE boost_bootstrap_result
    )

    if ( NOT boost_bootstrap_result EQUAL 0 )
        message( FATAL_ERROR "Unable to bootstrap Boost library!" )
    endif()

    #
    # build Boost
    #
    execute_process(
        COMMAND b2 headers
        WORKING_DIRECTORY ${boost_dir}
        RESULT_VARIABLE boost_build_result
    )

    if ( NOT boost_build_result EQUAL 0 )
        message( FATAL_ERROR "Unable to build Boost library!" )
    endif()

    #
    # let caller know include and library paths
    #
    set( Boost_INCLUDE_DIRS ${boost_dir}/boost )
    #set( Boost_LIBRARY_DIRS ${boost_dir}/stage/lib )
endif()
