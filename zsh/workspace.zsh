#!/bin/sh

# Display the usage information and the current settings
function usage() {
  echo "Usage: sel <branch> [<product> [<build-type>]]"
  echo " -or-  SRC=<path to source trees> sel <branch> [<product> [<build-type>]]"
  echo ""
  echo "Current settings:"
  echo ""
  echo " Branch name: ${VMBRANCH}"
  echo "      VMTREE: ${VMTREE}"
  echo "     Product: ${VMPROD}"
  echo "  Build type: ${BUILDTYPE}"
  return 1
}

function sel() {
  # If no parameters, type usage and current settings
  if [ -z $1 ]; then
    usage
    return 1
  fi

  # Set the project directory
  if [ -n ${1} ]; then
     if [ -d ${SRC}/${1} ]; then
       export VMBRANCH=${1}
       export VMTREE=${SRC}/${1}/bora
    else
       echo "ERROR: Folder doesn't exist: ${SRC}/${1}"
       echo "Branch name '${1}' misspelled, perhaps?"
    fi
  fi

  # Set product
  if [ -n "${2}" ]; then
    export VMPROD=${2}
  fi

  # Set build type
  if [ -n "${3}" ]; then
    export BUILDTYPE=${3}
  fi
}

