# Define: ssh_keygen
# Parameters:
# $home
# $filename
# $comment
# $type
# $bits
#
define ssh_keygen (
  $home     = "/home/${name}",
  $user     = $name,
  $filename = undef,
  $comment  = "${name}@${::fqdn}",
  $type     = 'rsa',
  $bits     = '2048',
) {

  Exec { path => '/bin:/usr/bin' }

  $filename_real = $filename ? {
    undef   => "${home}/.ssh/id_${type}",
    default => $filename,
  }

  exec { "ssh_keygen-${name}":
    command => "ssh-keygen -t ${type} -b ${bits} -f \"${filename_real}\" -N '' -C '${comment}'",
    user    => $user,
    creates => $filename_real,
  }

}
