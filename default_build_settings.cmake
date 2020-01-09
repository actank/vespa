# Copyright 2020 Oath Inc. Licensed under the terms of the Apache 2.0 license. See LICENSE in the project root.

include(VespaExtendedDefaultBuildSettings OPTIONAL)

function(setup_vespa_default_build_settings_rhel_6_10)
  message("-- Setting up default build settings for rhel 6.10")
endfunction()

function(setup_vespa_default_build_settings_rhel_7_7)
  message("-- Setting up default build settings for rhel 7.7")
  set(DEFAULT_EXTRA_LINK_DIRECTORY "${VESPA_DEPS}/lib64" "/usr/lib64/llvm5.0/lib" PARENT_SCOPE)
  set(DEFAULT_EXTRA_INCLUDE_DIRECTORY "${VESPA_DEPS}/include" "/usr/include/llvm5.0" PARENT_SCOPE)
  set(DEFAULT_VESPA_LLVM_VERSION "5.0" PARENT_SCOPE)
endfunction()

function(setup_vespa_default_build_settings_rhel_8_1)
  message("-- Setting up default build settings for rhel 8.1")
  set(DEFAULT_VESPA_LLVM_VERSION "7" PARENT_SCOPE)
endfunction()

function(setup_vespa_default_build_settings_centos_7)
  message("-- Setting up default build settings for centos 7")
  set(DEFAULT_EXTRA_LINK_DIRECTORY "${VESPA_DEPS}/lib64" "/usr/lib64/llvm5.0/lib" PARENT_SCOPE)
  set(DEFAULT_EXTRA_INCLUDE_DIRECTORY "${VESPA_DEPS}/include" "/usr/include/llvm5.0" PARENT_SCOPE)
  set(DEFAULT_VESPA_LLVM_VERSION "5.0" PARENT_SCOPE)
endfunction()

function(setup_vespa_default_build_settings_centos_8)
  message("-- Setting up default build settings for centos 8")
  set(DEFAULT_VESPA_LLVM_VERSION "7" PARENT_SCOPE)
endfunction()

function(setup_vespa_default_build_settings_darwin)
  message("-- Setting up default build settings for darwin")
  if("${CMAKE_CXX_COMPILER_ID}" STREQUAL "Clang" OR "${CMAKE_CXX_COMPILER_ID}" STREQUAL "AppleClang")
    set(DEFAULT_LLVM_INCLUDE_DIRECTORY "/usr/local/opt/llvm/include")
    set(DEFAULT_LLVM_LINK_DIRECTORY "/usr/local/opt/llvm/lib")
    set(DEFAULT_VESPA_LLVM_VERSION "9" PARENT_SCOPE)
  else()
    set(DEFAULT_VESPA_LLVM_VERSION "8" PARENT_SCOPE)
  endif()
  set(DEFAULT_CMAKE_PREFIX_PATH "${VESPA_DEPS}" "/usr/local/opt/bison" "/usr/local/opt/flex" "/usr/local/opt/openssl@1.1" PARENT_SCOPE)
  set(DEFAULT_EXTRA_LINK_DIRECTORY "${VESPA_DEPS}/lib" "/usr/local/opt/bison/lib" "/usr/local/opt/flex/lib" "/usr/local/opt/icu4c/lib" "/usr/local/opt/openssl@1.1/lib")
  if(DEFINED DEFAULT_LLVM_LINK_DIRECTORY)
    list(APPEND DEFAULT_EXTRA_LINK_DIRECTORY "${DEFAULT_LLVM_LINK_DIRECTORY}")
  endif()
  list(APPEND DEFAULT_EXTRA_LINK_DIRECTORY "/usr/local/lib")
  set(DEFAULT_EXTRA_LINK_DIRECTORY "${DEFAULT_EXTRA_LINK_DIRECTORY}" PARENT_SCOPE)
  set(DEFAULT_EXTRA_INCLUDE_DIRECTORY "${VESPA_DEPS}/include" "/usr/local/opt/flex/include" "/usr/local/opt/icu4c/include" "/usr/local/opt/openssl@1.1/include")
  if(DEFINED DEFAULT_LLVM_INCLUDE_DIRECTORY)
    list(APPEND DEFAULT_EXTRA_INCLUDE_DIRECTORY "${DEFAULT_LLVM_INCLUDE_DIRECTORY}")
  endif()
  list(APPEND DEFAULT_EXTRA_INCLUDE_DIRECTORY "/usr/local/include")
  set(DEFAULT_EXTRA_INCLUDE_DIRECTORY "${DEFAULT_EXTRA_INCLUDE_DIRECTORY}" PARENT_SCOPE)
endfunction()

function(setup_vespa_default_build_settings_fedora_29)
  message("-- Setting up default build settings for fedora 29")
  set(DEFAULT_VESPA_LLVM_VERSION "7" PARENT_SCOPE)
endfunction()

function(setup_vespa_default_build_settings_fedora_30)
  message("-- Setting up default build settings for fedora 30")
  set(DEFAULT_VESPA_LLVM_VERSION "8" PARENT_SCOPE)
endfunction()

function(setup_vespa_default_build_settings_fedora_31)
  message("-- Setting up default build settings for fedora 31")
  set(DEFAULT_VESPA_LLVM_VERSION "9" PARENT_SCOPE)
endfunction()

function(setup_vespa_default_build_settings_fedora_32)
  message("-- Setting up default build settings for fedora 32")
  set(DEFAULT_VESPA_LLVM_VERSION "9" PARENT_SCOPE)
endfunction()

function(setup_vespa_default_build_settings_ubuntu_18_10)
  message("-- Setting up default build settings for ubuntu 18.10")
  set(DEFAULT_EXTRA_LINK_DIRECTORY "${VESPA_DEPS}/lib" "/usr/lib/llvm-6.0/lib" PARENT_SCOPE)
  set(DEFAULT_EXTRA_INCLUDE_DIRECTORY "${VESPA_DEPS}/include" "/usr/lib/llvm-6.0/include" PARENT_SCOPE)
  set(DEFAULT_VESPA_LLVM_VERSION "6.0" PARENT_SCOPE)
endfunction()

function(vespa_use_default_build_settings)
  if (DEFINED CMAKE_INSTALL_PREFIX AND DEFINED CMAKE_PREFIX_PATH AND
      NOT CMAKE_INSTALL_PREFIX_INITIALIZED_TO_DEFAULT AND
      DEFINED VESPA_LLVM_VERSION AND
      DEFINED EXTRA_INCLUDE_DIRECTORY AND DEFINED EXTRA_LINK_DIRECTORY AND
      DEFINED CMAKE_INSTALL_RPATH AND DEFINED CMAKE_BUILD_RPATH)
    return()
  endif()
  set(VESPA_DEPS "/opt/vespa-deps")
  unset(DEFAULT_VESPA_LLVM_VERSION)
  unset(DEFAULT_CMAKE_PREFIX_PATH)
  unset(DEFAULT_EXTRA_LINK_DIRECTORY)
  unset(DEFAULT_EXTRA_INCLUDE_DIRECTORY)
  unset(DEFAULT_VESPA_USER)
  unset(DEFAULT_VESPA_CPU_ARCH_FLAGS)
  if(NOT DEFINED VESPA_UNPRIVILEGED)
    message("-- Setting VESPA_UNPRIVILEGED to yes")
    set(VESPA_UNPRIVILEGED "yes" PARENT_SCOPE)
    set(VESPA_UNPRIVILEGED "yes")
  endif()
  if(VESPA_UNPRIVILEGED STREQUAL "no")
    set(DEFAULT_CMAKE_INSTALL_PREFIX "/opt/vespa")
    set(DEFAULT_VESPA_USER "vespa")
    if(COMMAND vespa_use_specific_install_prefix)
      vespa_use_specific_install_prefix()
    endif()
    if(COMMAND vespa_use_specific_vespa_user)
      vespa_use_specific_vespa_user()
    endif()
  else()
    set(DEFAULT_CMAKE_INSTALL_PREFIX "$ENV{HOME}/vespa")
    set(DEFAULT_VESPA_USER "$ENV{USER}")
  endif()
  if(APPLE)
    if("${CMAKE_CXX_COMPILER_ID}" STREQUAL "Clang")
      set(VESPA_DEPS "/opt/vespa-deps-clang")
    elseif("${CMAKE_CXX_COMPILER_ID}" STREQUAL "AppleClang")
      set(VESPA_DEPS "/opt/vespa-deps-appleclang")
    endif()
  endif()
  if(COMMAND vespa_use_specific_vespa_deps)
    vespa_use_specific_vespa_deps()
  endif()
  if(COMMAND vespa_use_specific_compiler_rpath)
    vespa_use_specific_compiler_rpath()
  endif()
  if(COMMAND vespa_use_specific_llvm_version)
    vespa_use_specific_llvm_version()
  endif()
  if(VESPA_OS_DISTRO_COMBINED STREQUAL "rhel 6.10")
    setup_vespa_default_build_settings_rhel_6_10()
  elseif(VESPA_OS_DISTRO_COMBINED STREQUAL "rhel 7.7")
    setup_vespa_default_build_settings_rhel_7_7()
  elseif(VESPA_OS_DISTRO_COMBINED STREQUAL "rhel 8.1")
    setup_vespa_default_build_settings_rhel_8_1()
  elseif(VESPA_OS_DISTRO_COMBINED STREQUAL "centos 7")
    setup_vespa_default_build_settings_centos_7()
  elseif(VESPA_OS_DISTRO_COMBINED STREQUAL "centos 8")
    setup_vespa_default_build_settings_centos_8()
  elseif(VESPA_OS_DISTRO STREQUAL "darwin")
    setup_vespa_default_build_settings_darwin()
  elseif(VESPA_OS_DISTRO_COMBINED STREQUAL "fedora 29")
    setup_vespa_default_build_settings_fedora_29()
  elseif(VESPA_OS_DISTRO_COMBINED STREQUAL "fedora 30")
    setup_vespa_default_build_settings_fedora_30()
  elseif(VESPA_OS_DISTRO_COMBINED STREQUAL "fedora 31")
    setup_vespa_default_build_settings_fedora_31()
  elseif(VESPA_OS_DISTRO_COMBINED STREQUAL "fedora 32")
    setup_vespa_default_build_settings_fedora_32()
  elseif(VESPA_OS_DISTRO_COMBINED STREQUAL "ubuntu 18.10")
    setup_vespa_default_build_settings_ubuntu_18_10()
  else()
    message(FATAL_ERROR "-- Unkonwn vespa build platform ${VESPA_OS_DISTRO_COMBINED}")
  endif()
  if(NOT DEFINED VESPA_LLVM_VERSION AND NOT DEFINED DEFAULT_VESPA_LLVM_VERSION)
    message(FATAL_ERROR "-- Unkonwn default llvm version")
  endif()
  if(NOT DEFINED DEFAULT_CMAKE_PREFIX_PATH)
    set(DEFAULT_CMAKE_PREFIX_PATH "${VESPA_DEPS}")
  endif()
  if(NOT DEFINED DEFAULT_EXTRA_LINK_DIRECTORY)
    set(DEFAULT_EXTRA_LINK_DIRECTORY "${VESPA_DEPS}/lib64")
  endif()
  if(NOT DEFINED DEFAULT_EXTRA_INCLUDE_DIRECTORY)
    set(DEFAULT_EXTRA_INCLUDE_DIRECTORY "${VESPA_DEPS}/include")
  endif()
  if(NOT DEFINED DEFAULT_VESPA_CPU_ARCH_FLAGS)
    if(VESPA_OS_DISTRO STREQUAL "fedora" AND "${CMAKE_CXX_COMPILER_ID}" STREQUAL "Clang")
      set(DEFAULT_VESPA_CPU_ARCH_FLAGS "-march=westmere")
    endif()
  endif()
  if(DEFINED DEFAULT_CMAKE_INSTALL_PREFIX)
    message("-- DEFAULT_CMAKE_INSTALL_PREFIX is ${DEFAULT_CMAKE_INSTALL_PREFIX}")
  endif()
  if(DEFINED DEFAULT_CMAKE_PREFIX_PATH)
    message("-- DEFAULT_CMAKE_PREFIX_PATH is ${DEFAULT_CMAKE_PREFIX_PATH}")
  endif()
  if(DEFINED DEFAULT_EXTRA_LINK_DIRECTORY)
    message("-- DEFAULT_EXTRA_LINK_DIRECTORY is ${DEFAULT_EXTRA_LINK_DIRECTORY}")
  endif()
  if(DEFINED DEFAULT_EXTRA_INCLUDE_DIRECTORY)
    message("-- DEFAULT_EXTRA_INCLUDE_DIRECTORY is ${DEFAULT_EXTRA_INCLUDE_DIRECTORY}")
  endif()
  if(DEFINED DEFAULT_VESPA_LLVM_VERSION)
    message("-- DEFAULT_VESPA_LLVM_VERSION is ${DEFAULT_VESPA_LLVM_VERSION}")
  endif()
  if(DEFINED DEFAULT_VESPA_USER)
    message("-- DEFAULT_VESPA_USER is ${DEFAULT_VESPA_USER}")
  endif()
  if(DEFINED DEFAULT_VESPA_CPU_ARCH_FLAGS)
    message("-- DEFAULT_VESPA_CPU_ARCH_FLAGS is ${DEFAULT_VESPA_CPU_ARCH_FLAGS}")
  endif()
  if(CMAKE_INSTALL_PREFIX_INITIALIZED_TO_DEFAULT AND DEFINED DEFAULT_CMAKE_INSTALL_PREFIX)
    message("-- Setting CMAKE_INSTALL_PREFIX to ${DEFAULT_CMAKE_INSTALL_PREFIX}")
    set(CMAKE_INSTALL_PREFIX "${DEFAULT_CMAKE_INSTALL_PREFIX}" CACHE PATH "Install prefix for vespa project" FORCE)
  endif()
  if(NOT DEFINED CMAKE_PREFIX_PATH AND DEFINED DEFAULT_CMAKE_PREFIX_PATH)
    message("-- Setting CMAKE_PREFIX_PATH to ${DEFAULT_CMAKE_PREFIX_PATH}")
    set(CMAKE_PREFIX_PATH "${DEFAULT_CMAKE_PREFIX_PATH}" PARENT_SCOPE)
  endif()
  if(NOT DEFINED EXTRA_INCLUDE_DIRECTORY AND DEFINED DEFAULT_EXTRA_INCLUDE_DIRECTORY)
    message("-- Setting EXTRA_INCLUDE_DIRECTORY to ${DEFAULT_EXTRA_INCLUDE_DIRECTORY}")
    set(EXTRA_INCLUDE_DIRECTORY "${DEFAULT_EXTRA_INCLUDE_DIRECTORY}" PARENT_SCOPE)
  endif()
  if(NOT DEFINED EXTRA_LINK_DIRECTORY AND DEFINED DEFAULT_EXTRA_LINK_DIRECTORY)
    message("-- Setting EXTRA_LINK_DIRECTORY to ${DEFAULT_EXTRA_LINK_DIRECTORY}")
    set(EXTRA_LINK_DIRECTORY "${DEFAULT_EXTRA_LINK_DIRECTORY}" PARENT_SCOPE)
    set(EXTRA_LINK_DIRECTORY "${DEFAULT_EXTRA_LINK_DIRECTORY}")
  endif()
  if(NOT DEFINED CMAKE_INSTALL_RPATH)
    if(NOT "${VESPA_COMPILER_RPATH}" STREQUAL "${CMAKE_INSTALL_PREFIX}/lib64")
      list(APPEND CMAKE_INSTALL_RPATH "${CMAKE_INSTALL_PREFIX}/lib64")
    endif()
    if(DEFINED EXTRA_LINK_DIRECTORY)
      list(APPEND CMAKE_INSTALL_RPATH "${EXTRA_LINK_DIRECTORY}")
    endif()
    if(DEFINED VESPA_COMPILER_RPATH)
      list(APPEND CMAKE_INSTALL_RPATH "${VESPA_COMPILER_RPATH}")
    endif()
    message("-- Setting CMAKE_INSTALL_RPATH to ${CMAKE_INSTALL_RPATH}")
    set(CMAKE_INSTALL_RPATH "${CMAKE_INSTALL_RPATH}" PARENT_SCOPE)
  endif()
  if(NOT DEFINED CMAKE_BUILD_RPATH AND DEFINED VESPA_COMPILER_RPATH)
    if(DEFINED EXTRA_LINK_DIRECTORY)
      list(APPEND CMAKE_BUILD_RPATH "${EXTRA_LINK_DIRECTORY}")
    endif()
    list(APPEND CMAKE_BUILD_RPATH "${VESPA_COMPILER_RPATH}")
    if(DEFINED CMAKE_BUILD_RPATH)
      message("-- Setting CMAKE_BUILD_RPATH to ${CMAKE_BUILD_RPATH}")
      set(CMAKE_BUILD_RPATH "${CMAKE_BUILD_RPATH}" PARENT_SCOPE)
    endif()
  endif()
  if(NOT DEFINED VESPA_LLVM_VERSION AND DEFINED DEFAULT_VESPA_LLVM_VERSION)
    message("-- Setting VESPA_LLVM_VERSION to ${DEFAULT_VESPA_LLVM_VERSION}")
    set(VESPA_LLVM_VERSION "${DEFAULT_VESPA_LLVM_VERSION}" PARENT_SCOPE)
  endif()
  if(NOT DEFINED VESPA_USER AND DEFINED DEFAULT_VESPA_USER)
    message("-- Setting VESPA_USER to ${DEFAULT_VESPA_USER}")
    set(VESPA_USER "${DEFAULT_VESPA_USER}" PARENT_SCOPE)
  endif()
  if(NOT DEFINED VESPA_CPU_ARCH_FLAGS AND DEFINED DEFAULT_VESPA_CPU_ARCH_FLAGS)
    message("-- Setting VESPA_CPU_ARCH_FLAGS to ${DEFAULT_VESPA_CPU_ARCH_FLAGS}")
    set(VESPA_CPU_ARCH_FLAGS "${DEFAULT_VESPA_CPU_ARCH_FLAGS}" PARENT_SCOPE)
  endif()
endfunction()

function(vespa_use_default_cxx_compiler)
  if (DEFINED CMAKE_C_COMPILER AND DEFINED CMAKE_CXX_COMPILER)
    return()
  endif()
  unset(DEFAULT_CMAKE_C_COMPILER)
  unset(DEFAULT_CMAKE_CXX_COMPILER)
  if(NOT DEFINED VESPA_COMPILER_VARIANT OR VESPA_COMPILER_VARIANT STREQUAL "gcc")
    if(APPLE)
      set(DEFAULT_CMAKE_C_COMPILER "/usr/local/bin/gcc-9")
      set(DEFAULT_CMAKE_CXX_COMPILER "/usr/local/bin/g++-9")
    endif()
  elseif(VESPA_COMPILER_VARIANT STREQUAL "clang")
    if(APPLE)
      set(DEFAULT_CMAKE_C_COMPILER, "/usr/local/opt/llvm/bin/clang")
      set(DEFAULT_CMAKE_CXX_COMPILER "/usr/local/opt/llvm/bin/clang++")
    elseif(VESPA_OS_DISTRO STREQUAL "fedora")
      set(DEFAULT_CMAKE_C_COMPILER "/usr/bin/clang")
      set(DEFAULT_CMAKE_CXX_COMPILER "/usr/bin/clang++")
    else()
      message(FATAL_ERROR "-- clang compiler variant not supported for ${VESPA_OS_DISTRO_COMBINED}")
    endif()
  elseif(VESPA_COMPILER_VARIANT STREQUAL "appleclang")
    if(APPLE)
      set(DEFAULT_CMAKE_C_COMPILER "/usr/bin/clang")
      set(DEFAULT_CMAKE_CXX_COMPILER "/usr/bin/clang++")
    else()
      message(FATAL_ERROR "-- appleclang compiler variant not supported for ${VESPA_OS_DISTRO_COMBINED}")
    endif()
  else()
    message(FATAL_ERROR "-- unknown compiler variant ${VESPA_COMPILER_VARIANT}")
  endif()
  if(COMMAND vespa_use_specific_cxx_compiler)
    vespa_use_specific_cxx_compiler()
  endif()
  if(DEFINED DEFAULT_CMAKE_C_COMPILER)
    message("-- DEFAULT_CMAKE_C_COMPILER is ${DEFAULT_CMAKE_C_COMPILER}")
  endif()
  if(DEFINED DEFAULT_CMAKE_CXX_COMPILER)
    message("-- DEFAULT_CMAKE_CXX_COMPILER is ${DEFAULT_CMAKE_CXX_COMPILER}")
  endif()
  if(DEFINED DEFAULT_EXTRA_LINK_DIRECTORY)
    message("-- DEFAULT_EXTRA_LINK_DIRECTORY is ${DEFAULT_EXTRA_LINK_DIRECTORY}")
  endif()
  if(NOT DEFINED CMAKE_C_COMPILER AND DEFINED DEFAULT_CMAKE_C_COMPILER)
    message("-- Setting CMAKE_C_COMPILER to ${DEFAULT_CMAKE_C_COMPILER}")
    set(CMAKE_C_COMPILER "${DEFAULT_CMAKE_C_COMPILER}" PARENT_SCOPE)
  endif()
  if(NOT DEFINED CMAKE_CXX_COMPILER AND DEFINED DEFAULT_CMAKE_CXX_COMPILER)
    message("-- Setting CMAKE_CXX_COMPILER to ${DEFAULT_CMAKE_CXX_COMPILER}")
    set(CMAKE_CXX_COMPILER "${DEFAULT_CMAKE_CXX_COMPILER}" PARENT_SCOPE)
  endif()
endfunction()

function(vespa_use_default_java_home)
  if (DEFINED JAVA_HOME)
    return()
  endif()
  set(DEFAULT_JAVA_HOME "/usr/lib/jvm/java-11-openjdk")
  if(APPLE)
    execute_process(COMMAND "/usr/libexec/java_home" OUTPUT_VARIABLE DEFAULT_JAVA_HOME)
    string(STRIP "${DEFAULT_JAVA_HOME}" DEFAULT_JAVA_HOME)
  elseif(VESPA_OS_DISTRO STREQUAL "ubuntu")
    set(DEFAULT_JAVA_HOME "/usr/lib/jvm/java-11-openjdk-amd64" PARENT_SCOPE)
  endif()
  if(COMMAND vespa_use_specific_java_home)
    vespa_use_specific_java_home()
  endif()
  message("-- DEFAULT_JAVA_HOME is ${DEFAULT_JAVA_HOME}")
  if(NOT DEFINED JAVA_HOME AND DEFINED DEFAULT_JAVA_HOME)
    message("-- Setting JAVA_HOME to ${DEFAULT_JAVA_HOME}")
    set(JAVA_HOME "${DEFAULT_JAVA_HOME}" PARENT_SCOPE)
  endif()
endfunction()
