set(CTEST_BUILD_NAME "$ENV{CTEST_BUILD_NAME}")

set(CTEST_SOURCE_DIRECTORY $ENV{YAKL_CTEST_SRC})
set(CTEST_BINARY_DIRECTORY $ENV{YAKL_CTEST_BIN})
set(CTEST_NIGHTLY_START_TIME "18:00:00 EST")
set(CTEST_CMAKE_GENERATOR "Unix Makefiles")
set(CTEST_COVERAGE_COMMAND "gcov")
set(CTEST_MEMORYCHECK_COMMAND "/usr/bin/valgrind")

SET(CTEST_DROP_METHOD "http")
set(CTEST_SITE "thatchroof")
SET(CTEST_DROP_LOCATION "my.cdash.org/submit.php?project=YAKL")
SET(CTEST_DROP_SITE_CDASH TRUE)

set(CTEST_OPTIONS "") 
set(CTEST_OPTIONS "${CTEST_OPTIONS};-DYAKL_ARCH='$ENV{YAKL_ARCH}'") 
set(CTEST_OPTIONS "${CTEST_OPTIONS};-DYAKL_VERBOSE='$ENV{YAKL_VERBOSE}'") 
set(CTEST_OPTIONS "${CTEST_OPTIONS};-DYAKL_VERBOSE_FILE='$ENV{YAKL_VERBOSE_FILE}'") 
set(CTEST_OPTIONS "${CTEST_OPTIONS};-DYAKL_DEBUG='$ENV{YAKL_DEBUG}'") 
set(CTEST_OPTIONS "${CTEST_OPTIONS};-DYAKL_HAVE_MPI='$ENV{YAKL_HAVE_MPI}'") 
set(CTEST_OPTIONS "${CTEST_OPTIONS};-DYAKL_ENABLE_STREAMS='$ENV{YAKL_ENABLE_STREAMS}'") 
set(CTEST_OPTIONS "${CTEST_OPTIONS};-DYAKL_AUTO_PROFILE='$ENV{YAKL_AUTO_PROFILE}'") 
set(CTEST_OPTIONS "${CTEST_OPTIONS};-DYAKL_PROFILE='$ENV{YAKL_PROFILE}'") 
set(CTEST_OPTIONS "${CTEST_OPTIONS};-DYAKL_AUTO_FENCE='$ENV{YAKL_AUTO_FENCE}'") 
set(CTEST_OPTIONS "${CTEST_OPTIONS};-DYAKL_B4B='$ENV{YAKL_B4B}'") 
set(CTEST_OPTIONS "${CTEST_OPTIONS};-DYAKL_MANAGED_MEMORY='$ENV{YAKL_MANAGED_MEMORY}'") 
set(CTEST_OPTIONS "${CTEST_OPTIONS};-DYAKL_MEMORY_DEBUG='$ENV{YAKL_MEMORY_DEBUG}'") 
set(CTEST_OPTIONS "${CTEST_OPTIONS};-DYAKL_TARGET_SUFFIX='$ENV{YAKL_TARGET_SUFFIX}'") 
set(CTEST_OPTIONS "${CTEST_OPTIONS};-DYAKL_F90_FLAGS='$ENV{YAKL_F90_FLAGS}'") 
if (NOT "$ENV{YAKL_UNIT_CXX_LINK_FLAGS}" STREQUAL "")
  set(CTEST_OPTIONS "${CTEST_OPTIONS};-DYAKL_UNIT_CXX_LINK_FLAGS='$ENV{YAKL_UNIT_CXX_LINK_FLAGS}'") 
endif()
if (NOT "$ENV{YAKL_CXX_FLAGS}" STREQUAL "")
  set(CTEST_OPTIONS "${CTEST_OPTIONS};-DYAKL_CXX_FLAGS='$ENV{YAKL_CXX_FLAGS}'")
endif()
if (NOT "$ENV{YAKL_OPENMP_FLAGS}" STREQUAL "")
  set(CTEST_OPTIONS "${CTEST_OPTIONS};-DYAKL_OPENMP_FLAGS='$ENV{YAKL_OPENMP_FLAGS}'")
endif()
if (NOT "$ENV{YAKL_CUDA_FLAGS}" STREQUAL "")
  set(CTEST_OPTIONS "${CTEST_OPTIONS};-DYAKL_CUDA_FLAGS='$ENV{YAKL_CUDA_FLAGS}'")
endif()
if (NOT "$ENV{YAKL_HIP_FLAGS}" STREQUAL "")
  set(CTEST_OPTIONS "${CTEST_OPTIONS};-DYAKL_HIP_FLAGS='$ENV{YAKL_HIP_FLAGS}'")
endif()
if (NOT "$ENV{YAKL_SYCL_FLAGS}" STREQUAL "")
  set(CTEST_OPTIONS "${CTEST_OPTIONS};-DYAKL_SYCL_FLAGS='$ENV{YAKL_SYCL_FLAGS}'")
endif()

ctest_start("Nightly")
ctest_configure(BUILD ${CTEST_BINARY_DIRECTORY} SOURCE ${CTEST_SOURCE_DIRECTORY}/unit OPTIONS "${CTEST_OPTIONS}")
ctest_build()
ctest_test()
if ( "$ENV{CTEST_GCOV}" STREQUAL "1" )
  ctest_coverage()
endif()
if ( "$ENV{CTEST_VALGRIND}" STREQUAL "1" )
  ctest_memcheck()
endif()
ctest_submit()

