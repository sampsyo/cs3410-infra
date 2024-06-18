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
    root@9d6d042c8aa2:~# printf '#include <stdio.h>\nint main() { printf(\"hi!\\n"); }\n' > hi.c
    root@9d6d042c8aa2:~# riscv32-unknown-linux-gnu-gcc hi.c
    root@9d6d042c8aa2:~# qemu-riscv32 -L /opt/riscv/sysroot a.out
    hi!

[depot]: https://depot.dev/?utm_source=capra
[container]: https://github.com/sampsyo/cs3410-infra/pkgs/container/cs3410-infra
[docker]: https://www.docker.com

Visual Studio Code Setup
------------------------

There is also a simple [devcontainer][] configuration and `c_cpp_properties.json` configuration file for [Visual Studio Code][vscode].
Try opening this repository in VSCode and writing a simple C program to try it out.
The app should hopefully prompt you to "Reopen in Container," if you have the "Dev Containers" extension.

[devcontainer]: https://containers.dev
[vscode]: https://vscode.dev

Docker Instructions
-------------------

We will be using the Docker container to run all of your code this semester. You'll be able to write your files in a local directory and then run the code in the container. 

To run the image on a machine that is NOT Apple silicon (i.e. Windows and Intel Macs):
- Install Docker 
- Start the Docker Daemon
- `docker pull ghcr.io/sampsyo/cs3410-infra`
- `docker run -it -v --rm <absolute path to "shared">:/home/student/shared gchr.io/sampsyo/cs3410-infra bash`

To run the image on Apple silicon: 
- Install Docker (`brew install --cask docker`)
- Start Docker using `docker ps` 
- `docker pull ghcr.io/sampsyo/cs3410-infra`
- `docker run -it --platform linux/amd64 -v --rm <absolute path to "shared">:/home/student/shared gchr.io/sampsyo/cs3410-infra bash`

Notes:
- The shared folder you are on must exist locally. Create some directory on your machine for your 3410 work this semester, and use this as your shared directory 
- In the container, you'll be able to access these files by going to `/home/student/shared` (`cd /home/student/shared`)
- On Windows, remember to provide the absolute path to the shared folder in Windows form (starting with `C:`).
