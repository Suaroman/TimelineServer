#!/bin/bash

export KRB5CCNAME=/tmp/krb5cc_script

if [ -z "$1" ]; then
    echo "Usage: $0 [debug|info|trace]"
    exit 1
fi

log_level=${1,,}

hostname=$(hostname)
if [[ $hostname != hn0* ]]; then
    echo "Machine is not 'hn0'. Exiting..."
    exit 1
fi

keytab_file="/etc/security/keytabs/spnego.service.keytab"
principal=$(sudo su yarn -c "klist -kt '$keytab_file' | tail -n 1 | awk '{print \$4}'")

if [ -z "$principal" ]; then
    echo "Failed to extract the principal name from the keytab file."
    exit 1
fi

sudo su yarn -c "kinit -kt '$keytab_file' '$principal'"
if [ $? -ne 0 ]; then
    echo "Kerberos authentication failed."
    exit 1
fi

if [[ $log_level == "debug" || $log_level == "info" || $log_level == "trace" ]]; then
    sudo su yarn -c "yarn daemonlog -setlevel hn0-sparkg:8188 org.apache.hadoop $log_level 2> /dev/null"
    echo "Log level set to $log_level."
else
    echo "Invalid log level. Please use 'debug', 'info', or 'trace'."
fi
