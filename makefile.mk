################################################################################
# David Wisniewski
# Homework5 Make Files
#
#
#

all :

BUILD := debug
build_dir := ${CURDIR}/${BUILD}
exes := # Executables to build.

# ==== Begin define executable othello.
exes += othello
objects.othello = main.o game.o Myothello.o space.o
-include ${objects.othello:%.o=${build_dir}/%.d} # Include auto-generated dependencies.
# ==== End define executable othello.

# Boilerplate begin.

SHELL := /bin/bash

COMPILER=gcc

CXX.gcc := /bin/g++
CC.gcc := /bin/gcc
LD.gcc := /bin/g++
AR.gcc := /bin/ar

CXX.clang := /bin/clang++
CC.clang := /bin/clang
LD.clang := /bin/clang++
AR.clang := /bin/ar

CXX := ${CXX.${COMPILER}}
CC := ${CC.${COMPILER}}
LD := ${LD.${COMPILER}}
AR := ${AR.${COMPILER}}

CXXFLAGS.gcc.debug := -Og -fstack-protector-all
CXXFLAGS.gcc.release := -O3 -march=native -DNDEBUG
CXXFLAGS.gcc := -pthread -std=gnu++14 -march=native -W{all,extra,error} -g -fmessage-length=0 ${CXXFLAGS.gcc.${BUILD}}

CXXFLAGS.clang.debug := -O0 -fstack-protector-all
CXXFLAGS.clang.release := -O3 -march=native -DNDEBUG
CXXFLAGS.clang := -pthread -std=gnu++14 -march=native -W{all,extra,error} -g -fmessage-length=0 ${CXXFLAGS.clang.${BUILD}}

CXXFLAGS := ${CXXFLAGS.${COMPILER}}
CFLAGS := ${CFLAGS.${COMPILER}}

LDFLAGS.debug :=
LDFLAGS.release :=
LDFLAGS := -fuse-ld=gold -pthread -g ${LDFLAGS.${BUILD}}
LDLIBS := -ldl

COMPILE.CXX = ${CXX} -c -o $@ ${CPPFLAGS} -MD -MP ${CXXFLAGS} $(abspath $<)
PREPROCESS.CXX = ${CXX} -E -o $@ ${CPPFLAGS} ${CXXFLAGS} $(abspath $<)
COMPILE.C = ${CC} -c -o $@ ${CPPFLAGS} -MD -MP ${CFLAGS} $(abspath $<)
LINK.EXE = ${LD} -o $@ $(LDFLAGS) $(filter-out Makefile,$^) $(LDLIBS)
LINK.SO = ${LD} -shared -o $@ $(LDFLAGS) $(filter-out Makefile,$^) $(LDLIBS)
LINK.A = ${AR} rsc $@ $(filter-out Makefile,$^)

all : ${exes:%=${build_dir}/%} # Build all exectuables.

.SECONDEXPANSION:
${exes:%=${build_dir}/%} : ${build_dir}/% : $$(addprefix ${build_dir}/,$${objects.$$*}) Makefile | ${build_dir}
    $(strip ${LINK.EXE})

${exes:%=run_%} : run_% : ${build_dir}/%
    @echo "---- running $< ----"
    /usr/bin/time --verbose $<

${build_dir} :
    mkdir $@

${build_dir}/%.so : CXXFLAGS += -fPIC
${build_dir}/%.so : Makefile | ${build_dir}
    $(strip ${LINK.SO})

${build_dir}/%.a : Makefile | ${build_dir}
    $(strip ${LINK.A})

${build_dir}/%.o : %.cc Makefile | ${build_dir}
    $(strip ${COMPILE.CXX})

${build_dir}/%.o : %.c Makefile | ${build_dir}
    $(strip ${COMPILE.C})

clean :
    rm -rf ${build_dir}

.PHONY : clean all run_%

# Boilerplate end.
