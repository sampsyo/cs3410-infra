[![Built with Depot](https://depot.dev/badges/built-with-depot.svg)][depot]

CS 3410 Infrastructure
======================

This repository contains some public infrastructure for Cornell's CS 3410. Currently, there is only one thing here: a [Docker][] container for the RISC-V toolchain.

RISC-V Tools Container
----------------------

Thanks to [Depot][], we build a [container][] on every push to this repository.
Try this to get started:

    docker run -i -t --rm ghcr.io/sampsyo/cs3410-infra bash

Here's an example showing compilation and execution of a C program:

    $ docker run -i -t --rm ghcr.io/sampsyo/cs3410-infra bash
    root@9d6d042c8aa2:~# printf '#include <stdio.h>\nint main() { printf("hi!\\n"); }\n' > hi.c
    root@9d6d042c8aa2:~# gcc hi.c
    root@9d6d042c8aa2:~# qemu-riscv32 a.out
    hi!

[depot]: https://depot.dev/?utm_source=capra
[container]: https://github.com/sampsyo/cs3410-infra/pkgs/container/cs3410-infra
[docker]: https://www.docker.com

Using the Container
-------------------

A good way to use the container is to use [volumes][] to let it operate on files on your computer.
The key is to use something like ``-v `pwd`:/root`` to map the working directory on the host to the working directory within the container.
Try adding this alias to your `.profile` or similar:

    alias rv='docker run -it --rm -v `pwd`:/root ghcr.io/sampsyo/cs3410-infra'

Now you can run tools from the container by prefixing them with `rv`.
For example, here's how to do the same thing as above but with using files from the host filesystem:

    $ printf '#include <stdio.h>\nint main() { printf("hi!\\n"); }\n' > hi.c
    $ rv gcc hi.c
    $ file a.out
    a.out: ELF 32-bit LSB executable, UCB RISC-V, double-float ABI, version 1 (SYSV), dynamically linked, interpreter /lib/ld-linux-riscv32-ilp32d.so.1, for GNU/Linux 5.4.0, not stripped
    $ rv qemu-riscv32 a.out
    hi!

[volumes]: https://docs.docker.com/storage/volumes/

Visual Studio Code Setup
------------------------

There is also a simple [devcontainer][] configuration and `c_cpp_properties.json` configuration file for [Visual Studio Code][vscode].
Try opening this repository in VSCode and writing a simple C program to try it out.
The app should hopefully prompt you to "Reopen in Container," if you have the "Dev Containers" extension.

[devcontainer]: https://containers.dev
[vscode]: https://vscode.dev
