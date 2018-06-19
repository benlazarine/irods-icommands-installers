# irods-icommands-installers

Builds iCommands and iRODS FUSE user space installers and distro packages not
provided by RENCI for all the distributions iRODS supports

This builds user space installers for iCommands and iRODS FUSE client for all
of the operating systems that version 4.1.10 of iRODS supports.

Each installer is a posix shell script that will install the iCommands or the
stock iRODS FUSE client in a user chosen place. Then it will modify the user's
.bashrc so the executables are added to the path.

`irods-icommands-4.1.10-<distro>.installer` installs the iCommands.
`irods-fuse-4.1.10-<distro>.installer` installs the stock FUSE client.


## Initialzation

This repository depends on the `4.1.10` tag of the `irods/irods` github
repository.

Before using, the submodules need to be prepared.

```bash
prompt> git submodule init
prompt> git submodule update
prompt> (cd irods && git submodule init && git submodule update)
```


## Usage

Use `build.sh` to build all of the user space installers. It places them under
the `packages/` directory.

```bash
prompt> ./build.sh

prompt> tree packages
packages/
├── centos-6
│   ├── irods-fuse-4.1.10-centos-6.installer
│   └── irods-icommands-4.1.10-centos-6.installer
├── centos-7
│   ├── irods-fuse-4.1.10-centos-7.installer
│   └── irods-icommands-4.1.10-centos-7.installer
├── ubuntu-12
│   ├── irods-fuse-4.1.10-ubuntu-12.installer
│   └── irods-icommands-4.1.10-ubuntu-12.installer
└── ubuntu-14
    ├── irods-fuse-4.1.10-ubuntu-14.installer
    └── irods-icommands-4.1.10-ubuntu-14.installer

4 directories, 8 files
```
