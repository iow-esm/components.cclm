#!/bin/bash

debug=${1:-"release"}
rebuild=${2:-"fast"}

# LOAD REQUIRED MODULES
module load intel/18.0.5
module load impi/2018.5
module load netcdf/intel/4.7.3

# GET IOW ESM ROOT PATH
export IOW_ESM_ROOT="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )/../.."

# SET SYSTEM-SPECIFIC COMPILER OPTIONS AND PATHS
# compile mode: "PRODUCTION" or "DEBUG"
if [ $debug == "debug" ]; then
	export IOW_ESM_COMPILE_MODE="DEBUG"
elif [ $debug == "release" ]; then
	export IOW_ESM_COMPILE_MODE="PRODUCTION"
else
	echo "Compile mode is not specified correctly. Use debug or release"
	exit;
fi

# include paths
export IOW_ESM_NETCDF_INCLUDE="/sw/dataformats/netcdf/intel.18/4.7.3/skl/include"
export IOW_ESM_NETCDF_LIBRARY="/sw/dataformats/netcdf/intel.18/4.7.3/skl/lib"

# executables
export IOW_ESM_MAKE="/usr/bin/make -j 8"
export IOW_ESM_FC="mpiifort"
export IOW_ESM_LD="mpiifort"
# compiler flags
if [ $debug == "debug" ]; then
	export IOW_ESM_FFLAGS="-O1 -ftrapuv -fp-model strict -g -traceback -check all -xHost -save-temps -DOASIS_IOW_ESM -DIOW_ESM_DEBUG"
else
	export IOW_ESM_FFLAGS="-O3 -no-prec-div -fp-model fast=2 -xHost -save-temps -DOASIS_IOW_ESM"
fi
export IOW_ESM_LDFLAGS="-Wl,-rpath,${IOW_ESM_NETCDF_LIBRARY} -g -traceback"

# MAKE CLEAN
if [ $rebuild == "rebuild" ]; then
	rm -r ${IOW_ESM_ROOT}/components/CCLM/cclm/obj_${IOW_ESM_COMPILE_MODE}
	rm -r ${IOW_ESM_ROOT}/components/CCLM/cclm/work_${IOW_ESM_COMPILE_MODE}
	rm -r ${IOW_ESM_ROOT}/components/CCLM/cclm/bin_${IOW_ESM_COMPILE_MODE}
fi

mkdir -p ${IOW_ESM_ROOT}/components/CCLM/cclm/obj_${IOW_ESM_COMPILE_MODE}
mkdir -p ${IOW_ESM_ROOT}/components/CCLM/cclm/work_${IOW_ESM_COMPILE_MODE}
mkdir -p ${IOW_ESM_ROOT}/components/CCLM/cclm/bin_${IOW_ESM_COMPILE_MODE}

# RUN BUILD COMMAND
cd ${IOW_ESM_ROOT}/components/CCLM/cclm
${IOW_ESM_MAKE}
cd ${IOW_ESM_ROOT}/components/CCLM

