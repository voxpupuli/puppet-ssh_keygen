# Define: ssh_keygen
# Parameters:
# $user
# $type
# $bits
# $home
# $filename
# $comment
# $options
#
define ssh_keygen (
  $user     = undef,
  $type     = undef,
  $bits     = undef,
  $home     = undef,
  $filename = undef,
  $comment  = undef,
  $options  = undef,
) {

  Exec { path => '/bin:/usr/bin' }

  $user_real = $user ? {
    undef   => $name,
    default => $user,
  }

  $type_real = $type ? {
    undef   => 'rsa',
    default => $type,
  }

  $home_real = $home ? {
    undef   => $user_real ? {
      'root'  => "/${user_real}",
      default => "/home/${user_real}",
    },
    default => $home,
  }

  $filename_real = $filename ? {
    undef   => "${home_real}/.ssh/id_${type_real}",
    default => $filename,
  }

  $type_opt = " -t ${type_real}"

  $bits_opt = $bits ? {
    undef   => undef,
    default => " -b ${bits}"
  }

  $filename_opt = " -f '${filename_real}'"
  $n_passphrase_opt = " -N ''"

  $comment_opt = $comment ? {
    undef   => undef,
    default => " -C '${comment}'",
  }

  $options_opt = $options ? {
    undef   => undef,
    default => " ${options}",
  }

  exec { "ssh_keygen-${name}":
    command => "ssh-keygen${type_opt}${bits_opt}${filename_opt}${n_passphrase_opt}${comment_opt}${options_opt}",
    user    => $user_real,
    creates => $filename_real,
  }

}
