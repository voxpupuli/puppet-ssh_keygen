# frozen_string_literal: true

require 'spec_helper'

describe 'ssh_keygen' do
  let(:title) { 'john' }
  let(:facts) { { fqdn: 'www.acme.com' } }

  context 'not passing parameters' do
    let(:params) { {} }

    it {
      expect(subject).to contain_exec('ssh_keygen-john').with(
        command: "ssh-keygen -t rsa -f /home/john/.ssh/id_rsa -N ''",
        user: 'john',
        creates: '/home/john/.ssh/id_rsa'
      )
    }
  end

  context 'passing user other parameter' do
    let(:params) { { user: 'other' } }

    it {
      expect(subject).to contain_exec('ssh_keygen-john').with(
        command: "ssh-keygen -t rsa -f /home/other/.ssh/id_rsa -N ''",
        user: 'other',
        creates: '/home/other/.ssh/id_rsa'
      )
    }
  end

  context 'illegal params will be escaped' do
    let(:params) { { options: [';', 'rm', '-rf', '/'] } }

    it {
      expect(subject).to contain_exec('ssh_keygen-john').with(
        command: "ssh-keygen -t rsa -f /home/john/.ssh/id_rsa -N '' \\; rm -rf /",
        user: 'john',
        creates: '/home/john/.ssh/id_rsa'
      )
    }
  end

  context 'passing user root parameter' do
    let(:params) { { user: 'root' } }

    it {
      expect(subject).to contain_exec('ssh_keygen-john').with(
        command: "ssh-keygen -t rsa -f /root/.ssh/id_rsa -N ''",
        user: 'root',
        creates: '/root/.ssh/id_rsa'
      )
    }
  end

  context 'passing type parameter' do
    let(:params) { { type: 'dsa' } }

    it {
      expect(subject).to contain_exec('ssh_keygen-john').with(
        command: "ssh-keygen -t dsa -f /home/john/.ssh/id_dsa -N ''",
        user: 'john',
        creates: '/home/john/.ssh/id_dsa'
      )
    }
  end

  context 'passing bits parameter' do
    let(:params) { { bits: 4096 } }

    it {
      expect(subject).to contain_exec('ssh_keygen-john').with(
        command: "ssh-keygen -t rsa -b 4096 -f /home/john/.ssh/id_rsa -N ''",
        user: 'john',
        creates: '/home/john/.ssh/id_rsa'
      )
    }
  end

  context 'passing home parameter' do
    let(:params) { { home: '/h/j' } }

    it {
      expect(subject).to contain_exec('ssh_keygen-john').with(
        command: "ssh-keygen -t rsa -f /h/j/.ssh/id_rsa -N ''",
        user: 'john',
        creates: '/h/j/.ssh/id_rsa'
      )
    }
  end

  context 'passing filename parameter' do
    let(:title)  { 'root' }
    let(:params) { { filename: '/etc/ssh/ssh_host_rsa_key' } }

    it {
      expect(subject).to contain_exec('ssh_keygen-root').with(
        command: "ssh-keygen -t rsa -f /etc/ssh/ssh_host_rsa_key -N ''",
        user: 'root',
        creates: '/etc/ssh/ssh_host_rsa_key'
      )
    }
  end

  context 'passing comment parameter' do
    let(:params) { { comment: 'my key' } }

    it {
      expect(subject).to contain_exec('ssh_keygen-john').with(
        command: "ssh-keygen -t rsa -f /home/john/.ssh/id_rsa -N '' -C my\\ key",
        user: 'john',
        creates: '/home/john/.ssh/id_rsa'
      )
    }
  end

  context 'passing options parameter' do
    let(:params) { { options: ['-q'] } }

    it {
      expect(subject).to contain_exec('ssh_keygen-john').with(
        command: "ssh-keygen -t rsa -f /home/john/.ssh/id_rsa -N '' -q",
        user: 'john',
        creates: '/home/john/.ssh/id_rsa'
      )
    }
  end

  context 'overwrite existing key' do
    let(:params) { { force: true } }

    it {
      expect(subject).to contain_exec('ssh_keygen-john').with(
        command: "ssh-keygen -t rsa -f /home/john/.ssh/id_rsa -N '' -q <<<y",
        user: 'john',
        creates: '/home/john/.ssh/id_rsa'
      )
    }
  end
end
