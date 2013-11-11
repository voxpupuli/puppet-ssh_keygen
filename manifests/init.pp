# Define: ssh_keygen
# Parameters:
# $home
# $comment
#
define ssh_keygen(
  $home=undef,
  $comment=undef) {

  Exec { path => '/bin:/usr/bin' }

  $home_real = $home ? {
    undef => "/home/${name}",
    default => $home,
  }

  $comment_real = $comment ? {
    undef => "puppet generated key for ${name}@${::fqdn}",
    default => $comment,
  }

  exec { "ssh_keygen-${name}":
    command => "ssh-keygen -f \"${home_real}/.ssh/id_rsa\" -N '' -C '${comment_real}'",
    user    => $name,
    creates => "${home_real}/.ssh/id_rsa",
  }

}
