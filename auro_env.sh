#Source this file from .bashrc for flexible support for switching between
#release, debug, profile, x32 and x64 compilation modes.
#Your $PATH will be adjusted accordingly.

#Called each time an auro_compiler item changes. This function re-exports auro_compiler
#and adjusts $PATH accordingly
function auro_notify {
export auro_compiler=${auro_compiler_brand}-${auro_compiler_arch}-${auro_compiler_config}${auro_compiler_options}
echo auro_compiler: $auro_compiler
}


#Some defaults
export auro_compiler_brand=gcc
export auro_compiler_arch=x64
export auro_compiler_config=release
export auro_compiler_options=

auro_notify
function release {
export auro_compiler_config=release
auro_notify
}

function auro_gcc {
export auro_compiler_brand=gcc
auro_notify
}

function auro_clang {
export auro_compiler_brand=clang
auro_notify
}

function rtc {
export auro_compiler_config=release_rtc
auro_notify
}

function profile {
export auro_compiler_config=release_gprof
auro_notify
}

function debug {
export auro_compiler_config=debug
auro_notify
}

function pic {
    export auro_compiler_options=-pic
    auro_notify
} 


function x32 {
export auro_compiler_arch=x32
auro_notify
}

function x64 {
export auro_compiler_arch=x64
auro_notify
}

