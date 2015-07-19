reproenv
========

Automates the process of spawning and provisioning a Common Lisp
environment.

For now there are no plans to support customization through
configuration. It's more important to reliably reproduce an isolated,
standardardized working/testing environment.

Reproducibility in this context doesn't mean every spawned VM will be
the same bit-for-bit. External dependencies that aren't fixed to
particular versions include:

  - Vagrant
  - VirtualBox
  - VM base box
    - https://atlas.hashicorp.com/debian/boxes/jessie64
  - Debian packages
    - SBCL
    - Emacs
  - Quicklisp

Note this project and the features it provides will evolve. Don't
depend on it for fully consistent builds over extended periods of
time.


Dependencies
------------

- Vagrant (https://www.vagrantup.com/)
- VirtualBox (https://www.virtualbox.org/)


Usage
-----

Clone the repository:

    git clone git@github.com:jmitchell/reproenv.git

Then run `vagrant up` from the root directory of the
repository. Vagrant spawns a VM and provisions it with the
essentials. Once that's complete, login using `vagrant ssh`.
