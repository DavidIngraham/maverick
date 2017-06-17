require 'spec_helper'

describe 'collectd::plugin::ipmi', type: :class do
  let :pre_condition do
    'include ::collectd'
  end
  ######################################################################
  # Default param validation, compilation succeeds
  let :facts do
    {
      osfamily: 'RedHat',
      collectd_version: '4.8.0',
      operatingsystemmajrelease: '7',
      python_dir: '/usr/local/lib/python2.7/dist-packages'
    }
  end

  context ':ensure => present, default params' do
    let :facts do
      {
        osfamily: 'RedHat',
        collectd_version: '5.4',
        operatingsystemmajrelease: '7',
        python_dir: '/usr/local/lib/python2.7/dist-packages'
      }
    end

    it 'Will create /etc/collectd.d/10-ipmi.conf' do
      is_expected.to contain_file('ipmi.load').with(ensure: 'present',
                                                    path: '/etc/collectd.d/10-ipmi.conf',
                                                    content: '#\ Generated by Puppet\n<LoadPlugin ipmi>\n  Globals false\n</LoadPlugin>\n\n<Plugin "ipmi">\n  IgnoreSelected false\n  NotifySensorAdd false\n  NotifySensorRemove true\n  NotifySensorNotPresent false\n</Plugin>\n\n')
    end
  end

  ######################################################################
  # Remaining parameter validation, compilation fails

  context ':sensors param is not an array' do
    let :facts do
      {
        osfamily: 'RedHat',
        collectd_version: '5.4',
        operatingsystemmajrelease: '7',
        python_dir: '/usr/local/lib/python2.7/dist-packages'
      }
    end

    let :params do
      { sensors: true }
    end

    it 'Will raise an error about :sensors not being an array' do
      is_expected.to compile.and_raise_error(%r{array})
    end
  end

  context ':notify_sensor_not_present is not a bool' do
    let :facts do
      {
        osfamily: 'RedHat',
        collectd_version: '5.4',
        operatingsystemmajrelease: '7',
        python_dir: '/usr/local/lib/python2.7/dist-packages'
      }
    end
    let :params do
      { notify_sensor_not_present: 'true' }
    end

    it 'Will raise an error about :notify_sensor_not_present not being a boolean' do
      is_expected.to compile.and_raise_error(%r{"true" is not a boolean.  It looks to be a String})
    end
  end

  context ':notify_sensor_remove is not a bool' do
    let :facts do
      {
        osfamily: 'RedHat',
        collectd_version: '5.4',
        operatingsystemmajrelease: '7',
        python_dir: '/usr/local/lib/python2.7/dist-packages'
      }
    end
    let :params do
      { notify_sensor_remove: 'true' }
    end

    it 'Will raise an error about :notify_sensor_remove not being a boolean' do
      is_expected.to compile.and_raise_error(%r{"true" is not a boolean.  It looks to be a String})
    end
  end

  context ':notify_sensor_add is not a bool' do
    let :facts do
      {
        osfamily: 'RedHat',
        collectd_version: '5.4',
        operatingsystemmajrelease: '7',
        python_dir: '/usr/local/lib/python2.7/dist-packages'
      }
    end
    let :params do
      { notify_sensor_add: 'true' }
    end

    it 'Will raise an error about :notify_sensor_add not being a boolean' do
      is_expected.to compile.and_raise_error(%r{"true" is not a boolean.  It looks to be a String})
    end
  end

  context ':ignore_selected is not a bool' do
    let :facts do
      {
        osfamily: 'RedHat',
        collectd_version: '5.4',
        operatingsystemmajrelease: '7',
        python_dir: '/usr/local/lib/python2.7/dist-packages'
      }
    end
    let :params do
      { ignore_selected: 'true' }
    end

    it 'Will raise an error about :ignore_selected not being a boolean' do
      is_expected.to compile.and_raise_error(%r{"true" is not a boolean.  It looks to be a String})
    end
  end

  context ':interval is not default and is an integer' do
    let :facts do
      {
        osfamily: 'RedHat',
        collectd_version: '5.4',
        operatingsystemmajrelease: '7'
      }
    end
    let :params do
      { interval: 15 }
    end

    it 'Will create /etc/collectd.d/10-ipmi.conf' do
      is_expected.to contain_file('ipmi.load').with(ensure: 'present',
                                                    path: '/etc/collectd.d/10-ipmi.conf',
                                                    content: %r{^  Interval 15})
    end
  end

  context ':ensure => absent' do
    let :facts do
      {
        osfamily: 'RedHat',
        collectd_version: '5.4',
        operatingsystemmajrelease: '7',
        python_dir: '/usr/local/lib/python2.7/dist-packages'
      }
    end
    let :params do
      { ensure: 'absent' }
    end

    it 'Will not create /etc/collectd.d/10-ipmi.conf' do
      is_expected.to contain_file('ipmi.load').with(ensure: 'absent',
                                                    path: '/etc/collectd.d/10-ipmi.conf')
    end
  end
end
