Exec {
  path => "/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin",
}

exec { 'apt-update':
  command => '/usr/bin/apt-get update';
}

Exec["apt-update"] -> Package <| |>

node default {
    apt::ppa { "http://packages.ros.org/ros/ubuntu": key => "http://packages.ros.org/ros.key"; }

    package {
        'wget': ensure => latest;
        'python-software-properties': ensure => latest;
        'vim': ensure => latest;
        'git': ensure => latest;
        'dpkg': ensure => latest;
        'tmux': ensure => latest;
        'ros-hydro-desktop-full':
            ensure => latest,
            require => Apt::Ppa['http://packages.ros.org/ros/ubuntu'];
        'python-rosinstall':
            ensure => latest,
            require => Apt::Ppa['http://packages.ros.org/ros/ubuntu'];
    }
}

exec {'rosdep-init':
    command => '/usr/bin/rosdep init',
    require => Package['ros-hydro-desktop-full'],
    creates => '/etc/ros/rosdep/sources.list.d/20-default.list';
}

exec {'rosdep-update':
    command => '/usr/bin/rosdep update',
    require => Exec['rosdep-init'];
}

file {"/home/vagrant/.bashrc":
  source => "puppet:///modules/user/bashrc",
  mode   => 644,
  owner => 'vagrant',
  group => 'vagrant',
  require => Package['ros-hydro-desktop-full'];
}
