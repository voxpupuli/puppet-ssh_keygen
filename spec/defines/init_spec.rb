require 'spec_helper'

describe 'ssh_keygen' do

  let(:title) { 'john' }
  let(:facts) {{:fqdn => 'www.acme.com'}}

  context 'not passing parameters' do
    let(:params) { {} }

    it { should contain_exec('ssh_keygen-john').with(
      :command => "ssh-keygen -t rsa -b 2048 -f \"/home/john/.ssh/id_rsa\" -N '' -C 'john@www.acme.com'",
      :user    => 'john',
      :creates => '/home/john/.ssh/id_rsa'
    ) }
  end

  context 'passing home parameter' do
    let(:params) { {:home => '/h/j'} }

    it { should contain_exec('ssh_keygen-john').with(
      :command => "ssh-keygen -t rsa -b 2048 -f \"/h/j/.ssh/id_rsa\" -N '' -C 'john@www.acme.com'",
      :user    => 'john',
      :creates => '/h/j/.ssh/id_rsa'
    ) }
  end

  context 'passing filename parameter for host key' do
    let(:title)  { 'root' }
    let(:params) { {:filename => '/etc/ssh/ssh_host_rsa_key'} }

    it { should contain_exec('ssh_keygen-root').with(
      :command => "ssh-keygen -t rsa -b 2048 -f \"/etc/ssh/ssh_host_rsa_key\" -N '' -C 'root@www.acme.com'",
      :user    => 'root',
      :creates => '/etc/ssh/ssh_host_rsa_key'
    ) }
  end

  context 'passing comment parameter' do
    let(:params) { {:comment => 'my key'} }

    it { should contain_exec('ssh_keygen-john').with(
      :command => "ssh-keygen -t rsa -b 2048 -f \"/home/john/.ssh/id_rsa\" -N '' -C 'my key'",
      :user    => 'john',
      :creates => '/home/john/.ssh/id_rsa'
    ) }
  end

  context 'passing type parameter' do
    let(:params) { {:type => 'dsa'} }

    it { should contain_exec('ssh_keygen-john').with(
      :command => "ssh-keygen -t dsa -b 2048 -f \"/home/john/.ssh/id_dsa\" -N '' -C 'john@www.acme.com'",
      :user    => 'john',
      :creates => '/home/john/.ssh/id_dsa'
    ) }
  end

  context 'passing bits parameter' do
    let(:params) { {:bits => '4096'} }

    it { should contain_exec('ssh_keygen-john').with(
      :command => "ssh-keygen -t rsa -b 4096 -f \"/home/john/.ssh/id_rsa\" -N '' -C 'john@www.acme.com'",
      :user    => 'john',
      :creates => '/home/john/.ssh/id_rsa'
    ) }
  end

  context 'passing user parameter' do
    let(:params) { {:user => 'other'} }

    it { should contain_exec('ssh_keygen-john').with(
      :command => "ssh-keygen -t rsa -b 2048 -f \"/home/other/.ssh/id_rsa\" -N '' -C 'john@www.acme.com'",
      :user    => 'other',
      :creates => '/home/other/.ssh/id_rsa'
    ) }
  end

end
