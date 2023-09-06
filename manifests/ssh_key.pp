# Define: ssh_keygen::ssh_key
# Parameters:
# $ensure
# $generate
# $export_key
# $collect
# $user
# $type
# $bits
# $home
# $filename
# $comment
# $gen_options
# $auth_options
#
define ssh_keygen::ssh_key (
  $ensure        = present,
  $generate      = true,
  $export_key    = true,
  $export_suffix = undef,
  $collect       = undef,
  $user          = undef,
  $type          = undef,
  $bits          = undef,
  $home          = undef,
  $filename      = undef,
  $comment       = undef,
  $gen_options   = undef,
  $auth_options  = undef,
){

  $user_real = $user ? {
    undef   => $name,
    default => $user,
  }

  $type_real = $type ? {
    undef   => 'rsa',
    default => $type,
  }

  $collect_real = $collect ? {
    true    => "${user_real}-${::environment}${export_suffix}",
    default => $collect,
  }

  if $generate {
    ssh_keygen { $name:
      user     => $user,
      type     => $type,
      bits     => $bits,
      home     => $home,
      filename => $filename,
      comment  => $comment,
      options  => $gen_options,
    }
  }

  if $::settings::storeconfigs {
    # If we have made the ssh key yet - this takes one puppet run to show up
    if $export_key and getvar("::${user_real}_ssh${type_real}key") {
      $key_comment = getvar("::${user_real}_ssh${type_real}key_comment")
      @@ssh_authorized_key { "${key_comment}${export_suffix}":
        ensure  => $ensure,
        key     => getvar("::${user_real}_ssh${type_real}key"),
        options => $auth_options,
        type    => getvar("::${user_real}_ssh${type_real}key_type"),
        tag     => ["${user_real}${export_suffix}", "${user_real}-${::environment}${export_suffix}"],
      }
    }

    if $collect {
      unique(any2array($collect_real)).each |$collect_e| {
        Ssh_authorized_key <<| (title == $collect_e) or (tag == $collect_e) |>> {
          user => $user_real,
        }
      }
    }
  }
}
