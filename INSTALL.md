# AutoWAP

Automatically create a Wireless Access Point if HOME network is unavailable

This functionality is distributed as a Debian package, as a compressed source tarball,
and contained in an Apt Repository.

- The package and the tarball are available as part of a release on github
(`emthornber/AutoWAP`)

- The Apt repository is available at [MERG-DEV Apt
Repository](https://emthornber.github.io/rpirepo).  Visiting the site displays
instructions on how to setup the apt configuration to access the MERG-DEV
repository along with a downloadable script to carry out those instructions.

# Compiling

The .deb package is built using Easy Package Manager (EPM) (`emthornber/epm` tag
`v5.0.1rc2`) which is built from source using the usual autotools incantation

```
./configure
make
sudo make install
```

The build system used is [cmake](https://cmake.org)

```
cmake -S . -B build
cmake --build build --clean-first
```

# Installation

After a successful build there is a Debian package (and a portable tarball) in
`./pkg` e.g.

```
autowap-1.0.3-linux-6.6-all.deb
autowap-1.0.3-linux-6.6-all.tar.gz
```

which can be installed using `apt`

```
sudo apt install ./pkg/autowap-1.0.3-linux-6.6-all.tar.gz
```
