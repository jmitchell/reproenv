#!/bin/bash

function handle_non_zero_exit {
    if [ $? -ne 0 ] ; then
        echo "$1"
        exit $?
    fi
}

function install_apt_programs {
    sudo apt-get update
    sudo apt-get install -y emacs git sbcl sbcl-doc sbcl-source
}

function install_quicklisp {
    local temp_dir=$( mktemp -d )
    pushd $temp_dir

    # import Quicklisp's GPG release key
    local key_email="<release@quicklisp.org>"
    local key_fingerprint="D7A3 489D DEFE 32B7 D0E7  CC61 3079 65AB 028B 5FF7"    
    curl -O https://beta.quicklisp.org/release-key.txt
    gpg --import release-key.txt

    if [ $( gpg --fingerprint --list-keys "$key_email" | grep "$key_fingerprint" | wc -l ) -eq 0 ] ; then
        echo "Failed to import GPG release key"
        exit 1
    fi

    # download Quicklisp.lisp and its signature
    curl -O https://beta.quicklisp.org/quicklisp.lisp
    curl -O https://beta.quicklisp.org/quicklisp.lisp.asc

    gpg --verify quicklisp.lisp.asc quicklisp.lisp
    handle_non_zero_exit "GPG verification of Quicklisp failed"

    # prepare Lisp script and load into SBCL
    local bootstrap_file="ql.lisp"
    cat <<EOF > $bootstrap_file
(load "quicklisp")
(quicklisp-quickstart:install)
(let ((ql-util::*do-not-prompt* t))
  (ql:add-to-init-file))
(quit)
EOF

    chown -R vagrant:vagrant .
    su vagrant -c "sbcl --load $bootstrap_file"
    handle_non_zero_exit "SBCL failed while loading the Quicklisp bootstrap file"

    popd
    rm -rf $temp_dir
}

function link_to_host_configs {
    ln -s /host-home/.gitconfig /home/vagrant/.gitconfig

    ln -s /host-home/.ssh/id_rsa.pub /home/vagrant/.ssh/id_rsa.pub
    ln -s /host-home/.ssh/id_rsa /home/vagrant/.ssh/id_rsa
}

install_apt_programs
install_quicklisp
link_to_host_configs

