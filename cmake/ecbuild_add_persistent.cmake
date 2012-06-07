# (C) Copyright 1996-2012 ECMWF.
# 
# This software is licensed under the terms of the Apache Licence Version 2.0
# which can be obtained at http://www.apache.org/licenses/LICENSE-2.0. 
# In applying this licence, ECMWF does not waive the privileges and immunities 
# granted to it by virtue of its status as an intergovernmental organisation nor
# does it submit to any jurisdiction.

##############################################################################
# macro for adding persistent layer object classes
##############################################################################

macro( ecbuild_add_persistent )

    set( options ) # no options
    set( single_value_args SRC_LIST ) # to which target source list to add the object classes
    set( multi_value_args  FILES )  # list of files to process

    cmake_parse_arguments( _PAR "${options}" "${single_value_args}" "${multi_value_args}"  ${_FIRST_ARG} ${ARGN} )

    if(_PAR_UNPARSED_ARGUMENTS)
      message(FATAL_ERROR "Unknown keywords given to ecbuild_add_persistent(): \"${_PAR_UNPARSED_ARGUMENTS}\"")
    endif()

    if( NOT _PAR_SRC_LIST  )
      message(FATAL_ERROR "The call to ecbuild_add_persistent() doesn't specify the SRC_LIST.")
    endif()

    if( NOT _PAR_FILES )
      message(FATAL_ERROR "The call to ecbuild_add_persistent() doesn't specify the FILES.")
    endif()

    foreach( file ${_PAR_FILES} )
      add_custom_command(
        OUTPUT  ${file}.b
        COMMAND ${sg_perl} ${CMAKE_CURRENT_SOURCE_DIR}/${file}.h ${CMAKE_CURRENT_BINARY_DIR}
        DEPENDS ${file}.h
        )
      set_source_files_properties( ${file}.h PROPERTIES OBJECT_DEPENDS "${file}.b" )
      list( APPEND ${_PAR_SRC_LIST} ${file}.b )
    endforeach()

endmacro( ecbuild_add_persistent  )
