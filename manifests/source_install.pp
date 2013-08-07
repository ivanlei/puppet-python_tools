# python_tools::source_install
#
# This object installs a python package after downloading it from a version control repository.
#
# Parameters:
#
#  repo_url:
#    Set the url to download from.
#
#  repo_name: (default $name)
#    Set the name of the folder in /tmp/ to download the repo to.
#
#  setup_path: (default '')
#    If set, the relative path within the downloaded repo to run setup.py from.
#
#  provider: (default 'git')
#    If set, the version control package to use.
#
# Actions:
#   - Download package from source control to /tmp dir
#   - Installs package
#   - Removes downloaded sourcs
#
# Requires:
#   - stdlib
#
# Sample Usage:
#  For a standard install from github:
#    python_tools::source_install { 'simplejson':
#      repo_url  => 'https://github.com/simplejson/simplejson.git',
#    }
#
#  For a package like keyczar, where setup.py is not in the root of the repository:
#    python_tools::source_install { 'keyczar':
#      repo_url   => 'https://code.google.com/p/keyczar',
#      repo_name  => 'keyczar',
#      setup_path => 'python',
#    }
#
#  For an install with mercurial:
#    python_tools::source_install { 'scapy':
#      repo_url => 'http://hg.secdev.org/scapy',
#      provider => 'hg',
#    }
#
define python_tools::source_install(
  $repo_url,
  $repo_name     = $name,
  $setup_path    = '',
  $provider      = 'git',
  )
{
  require git

  validate_string($repo_url, $repo_name, $setup_path, $provider)

  $repo_path = "/tmp/${repo_name}"
  $exec_name = "install_${repo_name}"

  vcsrepo { $repo_path:
    ensure    => present,
    provider  => $provider,
    source    => $repo_url,
    require   => Class[$provider],
  }

  exec { $exec_name:
    command   => 'sudo python setup.py install',
    cwd       => "${repo_path}/${setup_path}",
    path      => ['/usr/bin', '/usr/sbin'],
    require   => Vcsrepo[$repo_path],
  }

  file { $repo_path:
    ensure    => absent,
    force     => true,
    require   => Exec[$exec_name],
  }
}