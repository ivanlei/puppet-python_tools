# Class: python_tools
#
# This class installs python_tools
#
# Requires:
#   - python_pip
#
# Actions:
#   - Install the python_pip package
#   - Install the virtualenv package using pip
#   - Install the python3 package
#   - Install the pudb package
#   - Install the ipython package
#
# Sample Usage:
#  class { 'python_tools': }
#
class python_tools {
  require python_pip

  $pip_packages = ['pudb', 'virtualenv', 'simplejson', 'xmltodict', 'keyring']
  $packages = ['python3', 'ipython']

  package { $pip_packages:
    ensure    => present,
    provider  => 'pip'
  }

  package { $packages:
    ensure => present
  }

  python_tools::source_install { 'keyczar':
    repo_url      => 'https://code.google.com/p/keyczar',
    repo_name     => 'keyczar',
    install_path  => 'python',    
  }
}