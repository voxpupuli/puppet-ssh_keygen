# Define: ssh_keygen
# Parameters:
# $home
#
define ssh_keygen($home=undef) {

  Exec { path => '/bin:/usr/bin' }

  if $home == undef {
    $home_real = "/home/${name}"
  } else {
    $home_real = $home
  }

  exec { "ssh_keygen-${name}":
    command => "ssh-keygen -f \"${home_real}/.ssh/id_rsa\" -N '' -C 'puppet generated key'",
    user    => $name,
    creates => "${home_real}/.ssh/id_rsa",
  }

}
