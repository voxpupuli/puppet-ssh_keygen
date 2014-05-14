puppet-ssh_keygen
=================

Generation of ssh keys with ssh-keygen

Generate ssh keys for any user using ssh_keygen, that needs exist before using the module
```puppet
ssh_keygen { 'john': }
```

or if not using the default `/home/john`
```puppet
ssh_keygen { 'john':
  home => '/var/home'
}
```

the key comment can also be overriden with
```puppet
ssh_keygen { 'john':
  comment => 'john key'
}
```

Generate a dsa key
```puppet
ssh_keygen { 'john':
  type => 'dsa'
}
```

specify the bit length
```puppet
ssh_keygen { 'john':
  bits => '4096'
}
```

Generate new host key
```puppet
ssh_keygen { 'root':
  filename => '/etc/ssh/ssh_host_rsa_key'
}
```
