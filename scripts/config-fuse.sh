#!/bin/sh

printf 'Updating .bashrc\n'
cat <<EOS >>"$HOME"/.bashrc 

# iRODS FUSE support
export LD_LIBRARY_PATH=$INSTALL_BASE/irods-fuse/lib\${LD_LIBRARY_PATH/\$LD_LIBRARY_PATH/:\$LD_LIBRARY_PATH}
export PATH=$INSTALL_BASE/irods-fuse/bin:\$PATH
EOS

printf 'done!\n\n'
printf 'To make the changes take effect in the current shell, please source your bashrc file, i.e., `. ~/.bashrc`.\n'
