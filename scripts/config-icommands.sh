#! /bin/sh

#readonly Bashrc="$HOME"/.bashrc
#readonly ICommandsBase="$INSTALL_BASE"/icommands

printf 'Updating .bashrc\n'
#if grep --no-messages 'IRODS_PLUGINS_HOME='
#then
#  sed --in-place "s/IRODS_PLUGINS_HOME=.*$/IRODS_PLUGINS_HOME=$ICommandsBase/plugins/" "$Bashrc"
#else
#  echo export IRODS_PLUGINS_HOME="$ICommandsBase"/plugins/ >> "$Bashrc"
#fi

#if grep --no-messages 'IRODS_ICOMMANDS_PATH='
#then
#  sed --in-place "s/IRODS_ICOMMANDS_PATH=.*$/IRODS_ICOMMANDS_PATH=$ICommandsBase/" "$Bashrc"
#else
#  echo export IRODS_ICOMMANDS_PATH="$ICommandsBase" >> "$Bashrc"
#fi

cat <<EOS >>"$HOME"/.bashrc

# iRODS iCommands support
export IRODS_PLUGINS_HOME=$INSTALL_BASE/icommands/plugins/
export PATH=$INSTALL_BASE/icommands:\$PATH
EOS

printf 'done!\n\n'
printf 'To make the changes take effect in the current shell, please source your bashrc file, i.e., `. ~/.bashrc`.\n'
