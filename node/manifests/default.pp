exec { "update":
    command => "/usr/bin/apt-get update"
}

exec { "download-node":
	require => Exec["update"],
	command => "/usr/bin/curl -sL https://deb.nodesource.com/setup_0.12 | sudo bash -"
}

exec { "download-docker":
	require => Package["linux-image-generic-lts-trusty"],
	command => "/usr/bin/curl -sSL https://get.docker.com/ | sh"
}

package { "linux-image-generic-lts-trusty":
	require => Exec["update"],
	ensure => installed
}

package { ["nodejs", "git"]:
    ensure => installed,
    require => Exec["download-node"]
}