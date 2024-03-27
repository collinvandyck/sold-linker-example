# Overview

This project attempts to get the sold linker working on ARM macs with Rust.

# Usage

    make

The script will first download and build the sold linker, if the dist files are
not already present.

It will then write a .cargo/config.toml file that instructs cargo to use the built linker.

It will then (try to) run a hello world run program.

# Issues

It doesn't work just yet.


    clang: error: unable to execute command: Abort trap: 6
    clang: error: linker command failed due to signal (use -v to see invocation)
