# irods-icommands-installers
Builds iCommands and iRODS FUSE user space installers and distro packages not provided by RENCI for all the distributions iRODS supports

This builds user space installers for iCommands and iRODS FUSE client for all of the operating systems that version 4.1.9 of iRODS supports. It also builds the distro packages containing the iCommands with CyVerse's custom iRODS FUSE client for the supported OSes.

Each installer is a posix shell script that will install the iCommands, the stock iRODS FUSE client, or CyVerse's custom iRODS FUSE client  in a user chosen place. Then it will modify the user's .bashrc so the executables are added to the path.

`irods-icommands-4.1.9-<distro>.installer` installs the iCommands. `irods-fuse-4.1.9-<distro>.installer` installs the stock FUSE client. `irods-fuse-4.1.9-cv-<distro>.installer` installs CyVerse's custom FUSE client.

## Initialzation

This repository depends on the `4.1.9` tag of the `irods/irods` github repository.

Before using, the submodules need to be prepared. 

```
prompt> git submodule init
prompt> git submodule update
prompt> (cd irods && git checkout 4.1.9 && git submodule init && git submodule update)
prompt> (cd cyverse-irods && git submodule init && git submodule update)
```

## Usage

Use `build.sh` to build all of the user space installers. It places them under the `packages/` directory.

```
prompt> ./build.sh
    
prompt> tree packages
packages/
├── centos-6
│   ├── irods-fuse-4.1.9-centos-6.installer
│   ├── irods-fuse-4.1.9-cv-centos-6.installer
│   ├── irods-icommands-4.1.9-centos-6.installer
│   └── irods-icommands-4.1.9-cv-64bit-centos6.rpm
├── centos-7
│   ├── irods-fuse-4.1.9-centos-7.installer
│   ├── irods-fuse-4.1.9-cv-centos-7.installer
│   ├── irods-icommands-4.1.9-centos-7.installer
│   └── irods-icommands-4.1.9-cv-64bit-centos7.rpm
├── opensuse-13
│   ├── irods-fuse-4.1.9-cv-opensuse-13.installer
│   ├── irods-fuse-4.1.9-opensuse-13.installer
│   ├── irods-icommands-4.1.9-cv-64bit-suse.rpm
│   └── irods-icommands-4.1.9-opensuse-13.installer
├── ubuntu-12
│   ├── irods-fuse-4.1.9-cv-ubuntu-12.installer
│   ├── irods-fuse-4.1.9-ubuntu-12.installer
│   ├── irods-icommands-4.1.9-cv-64bit-ubuntu-12.deb
│   └── irods-icommands-4.1.9-ubuntu-12.installer
└── ubuntu-14
    ├── irods-fuse-4.1.9-cv-ubuntu-14.installer
    ├── irods-fuse-4.1.9-ubuntu-14.installer
    ├── irods-icommands-4.1.9-cv-64bit-ubuntu-14.deb
    └── irods-icommands-4.1.9-ubuntu-14.installer

5 directories, 20 files
```
