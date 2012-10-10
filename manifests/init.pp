# = Class: java
#
# Manage Java through Puppet
#
# == Parameters:
#
# == Actions:
#   Install JDK 1.7.0
#
# == Requires:
#   - Module['Archive']
class java {
	$url32 = "http://download.oracle.com/otn-pub/java/jdk/7u7-b10/jdk-7u7-linux-i586.tar.gz"
	$url64 = "http://download.oracle.com/otn-pub/java/jdk/7u7-b10/jdk-7u7-linux-x64.tar.gz"

    Exec {
         path => "/home/vagrant/.rvm/gems/ruby-1.9.3-p194/bin:/home/vagrant/.rvm/gems/ruby-1.9.3-p194@global/bin:/home/vagrant/.rvm/rubies/ruby-1.9.3-p194/bin:/home/vagrant/.rvm/bin:/usr/lib64/ccache:/usr/local/bin:/bin:/usr/bin:/usr/local/sbin:/usr/sbin:/sbin:/home/vagrant/.rvm/bin:/sbin:/usr/sbin:/home/vagrant/.local/bin:/home/vagrant/bin"
     }

    file { '/usr/java/':
        ensure => directory,
        owner  => root,
        group  => root,
        mode   => 0775,
    }

    archive::download { "jdk-7u7-linux-i586.tar.gz":
	    ensure        => present,
	    url           => $url32,
		agent         => "Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.1.16) Gecko/20120421 Firefox/11.0",
		cookie        => "gpw_e24=http%3A%2F%2Fwww.oracle.com%2F",
        timeout       => 300,
	    checksum      => false,
    }

    archive::extract { "jdk-7u7-linux-i586":
        ensure     => present,
        target     => "/usr/java",
        require    => Archive::Download["jdk-7u7-linux-i586.tar.gz"]
    }

	file { '/usr/java/latest':
		ensure => link,
		target => '/usr/java/jdk1.7.0_07',
	}
} 