# Fact: user_ssh_keys
#
# Purpose: snatching the public ssh keys of all users
#
# Resolution:
#   reads each users home dir/.ssh/pub key and returns the contents.
#
# Caveats:
#   none
#
# Notes:
#   We need the pub key details for export to other nodes

def login_users
  Puppet::Type.type('user').instances.select do |user|
    %w[root puppet jenkins].include?(user.name) ||
      user.retrieve[user.property(:uid)].to_i >= 500
  end
end

def add_facts_for_user(user)
  sshdir = File.join(user.retrieve[user.property(:home)], '.ssh')

  %w[rsa dsa].each do |keytype|
    pubpath = File.join(sshdir, "id_#{keytype}.pub")

    next unless File.file?(pubpath)
    type, key, comment = Facter::Util::FileRead.read(pubpath).chomp.split($FS, 3)
    fact_base = :"#{user.name}_ssh#{keytype}key"

    Facter.add(fact_base) do
      setcode { key }
    end

    Facter.add(:"#{fact_base}_comment") do
      setcode { comment }
    end

    Facter.add(:"#{fact_base}_type") do
      setcode { type }
    end
  end
end

login_users.each { |user| add_facts_for_user(user) }
