# irods-icommands-installers
Builds iCommands and iRODS FUSE user space installers for all the distributions iRODS supports

This builds user space installers for iCommands and iRODS FUSE client for all of the operating systems that version 4.1.9 of iRODS supports.

Each installer is a posix shell script that will install the iCommands or iRODS FUSE client in a user chosen place. Then it will modify the user's .bashrc so the executables are added to the path.

## Initialzation

This repository depends on the `4.1.9` tag of the `irods/irods` github repository.

Before using, the submodules need to be prepared. 

```
prompt> git submodule init
prompt> git submodule update
prompt> cd irods
prompt> git checkout 4.1.9
prompt> git submodule init
prompt> git submodule update
prompt> cd ..
```

## Usage

Use `build.sh` to build all of the user space installers. It places them under the `packages/` directory.

```
prompt> ./build.sh
    
prompt> tree packages
packages
├── centos-6
│   ├── irods-fuse-4.1.9-centos-6.installer
│   └── irods-icommands-4.1.9-centos-6.installer
├── centos-7
│   ├── irods-fuse-4.1.9-centos-7.installer
│   └── irods-icommands-4.1.9-centos-7.installer
├── opensuse-13
│   ├── irods-fuse-4.1.9-opensuse-13.installer
│   └── irods-icommands-4.1.9-opensuse-13.installer
├── ubuntu-12
│   ├── irods-fuse-4.1.9-ubuntu-12.installer
│   └── irods-icommands-4.1.9-ubuntu-12.installer
└── ubuntu-14
    ├── irods-fuse-4.1.9-ubuntu-14.installer
    └── irods-icommands-4.1.9-ubuntu-14.installer

5 directories, 10 files
```


