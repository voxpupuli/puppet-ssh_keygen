require 'spec_helper'

describe 'ssh_keygen' do

  let(:title) { 'john' }
  let(:facts) {{:fqdn => 'www.acme.com'}}

  context 'not passing parameters' do
    let(:params) { {} }

    it { should contain_exec('ssh_keygen-john').with(
      :creates => '/home/john/.ssh/id_rsa',
      :command => "ssh-keygen -f \"/home/john/.ssh/id_rsa\" -N '' -C 'puppet generated key for john@www.acme.com'") }
  end

  context 'passing home parameter' do
    let(:params) { {:home => '/h/j'} }

    it { should contain_exec('ssh_keygen-john').with_creates('/h/j/.ssh/id_rsa') }
  end

  context 'passing comment parameter' do
    let(:params) { {:comment => 'my key'} }

    it { should contain_exec('ssh_keygen-john').with_command("ssh-keygen -f \"/home/john/.ssh/id_rsa\" -N '' -C 'my key'") }
  end

end
