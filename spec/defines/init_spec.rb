require 'spec_helper'

describe 'ssh_keygen' do

  let(:title) { 'john' }

  context 'passing home parameter' do
    let(:params) { {:home => '/h/j'} }

    it { should contain_exec('ssh_keygen-john').with_creates('/h/j/.ssh/id_rsa') }
  end

  context 'not passing home' do
    let(:params) { {} }

    it { should contain_exec('ssh_keygen-john').with_creates('/home/john/.ssh/id_rsa') }
  end

end
