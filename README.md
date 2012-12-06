puppet-ssh_keygen
=================

Generation of ssh keys with ssh-keygen

Generate ssh keys for any user using ssh_keygen, that needs exist before using the module

    ssh_keygen { 'john': }

or if not using the default `/home/john`

    ssh_keygen { 'john':
      home => '/var/home'
    }
