# Define: ssh_keygen
# Parameters:
# $home
# $filename
# $comment
# $type
# $bits
#
define ssh_keygen (
  $home     = undef,
  $user     = undef,
  $filename = undef,
  $comment  = "${name}@${::fqdn}",
  $type     = 'rsa',
  $bits     = '2048',
) {

  Exec { path => '/bin:/usr/bin' }

  $user_real = $user ? {
    undef   => $name,
    default => $user,
  }

  $home_real = $home ? {
    undef   => "/home/${user_real}",
    default => $home,
  }

  $filename_real = $filename ? {
    undef   => "${home_real}/.ssh/id_${type}",
    default => $filename,
  }

  exec { "ssh_keygen-${name}":
    command => "ssh-keygen -t ${type} -b ${bits} -f \"${filename_real}\" -N '' -C '${comment}'",
    user    => $user_real,
    creates => $filename_real,
  }

}
