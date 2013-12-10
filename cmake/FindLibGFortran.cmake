# © Copyright 1996-2012 ECMWF.
# 
# This software is licensed under the terms of the Apache Licence Version 2.0
# which can be obtained at http://www.apache.org/licenses/LICENSE-2.0. 
# In applying this licence, ECMWF does not waive the privileges and immunities 
# granted to it by virtue of its status as an intergovernmental organisation nor
# does it submit to any jurisdiction.

###############################################################################
# gfortran libs

set( __libgfortran_names gfortran libgfortran.so.1 libgfortran.so.3 )

execute_process(COMMAND "gfortran" "-print-search-dirs"
    RESULT_VARIABLE _GFORTRAN_SEARCH_SUCCESS
    OUTPUT_VARIABLE _GFORTRAN_VALUES_OUTPUT
    ERROR_VARIABLE _GFORTRAN_ERROR_VALUE
    OUTPUT_STRIP_TRAILING_WHITESPACE)

debug_var(_GFORTRAN_SEARCH_SUCCESS)
debug_var(_GFORTRAN_VALUES_OUTPUT)
debug_var(_GFORTRAN_ERROR_VALUE)

if(_GFORTRAN_SEARCH_SUCCESS MATCHES 0)
    string(REGEX REPLACE ".*libraries: =(.*)" "\\1" _result  ${_GFORTRAN_VALUES_OUTPUT})
    string(REGEX REPLACE ":" ";" _result  ${_result})
    debug_var(_result)

    set(_MORE_HINTS ${_result})
endif()

find_library( GFORTRAN_LIB NAMES ${__libgfortran_names}  HINTS ${LIBGFORTRAN_PATH} ENV LIBGFORTRAN_PATH PATHS PATH_SUFFIXES lib64 lib NO_DEFAULT_PATH )
find_library( GFORTRAN_LIB NAMES ${__libgfortran_names}  HINTS ${_MORE_HINTS} PATHS PATH_SUFFIXES lib64 lib )

mark_as_advanced( GFORTRAN_LIB )

if( GFORTRAN_LIB )
	set( GFORTRAN_LIBRARIES ${GFORTRAN_LIB} )
endif()

include(FindPackageHandleStandardArgs)

find_package_handle_standard_args( LIBGFORTRAN  DEFAULT_MSG GFORTRAN_LIBRARIES  )


