reproenv
========

Automates the process of spawning and provisioning a Common Lisp
environment.

For now there are no plans to support customization through
configuration. It's more important to reliably reproduce an isolated,
standardardized working/testing environment.

Note this project will evolve, so don't depend on it for fully
consistent builds over extended periods of time.


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

