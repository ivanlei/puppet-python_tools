puppet-python_tools
===================

A repository to install simple python tools and/or to download and install python packages from source control

Base Toolkit
------------
The base toolkit installs ```pudb```, ```virtualenv```, ```simplejson```, ```xmltodict```, ```keyring```, ```python3```, ```ipython```, ```keyczar```<br>
Installation is simple:
```ruby
class { 'python_tools': }
```

Installing Packages from Source
-------------------------------
For a standard install from github:
```ruby
python_tools::source_install { 'simplejson':
 repo_url  => 'https://github.com/simplejson/simplejson.git',
}
```

For a package like keyczar, where setup.py is not in the root of the repository:
```ruby
python_tools::source_install { 'keyczar':
 repo_url      => 'https://code.google.com/p/keyczar',
 repo_name     => 'keyczar',
 install_path  => 'python',    
}
```

For an install with mercurial:
```ruby
python_tools::source_install { 'scapy':
 repo_url => 'http://hg.secdev.org/scapy',
 provider => 'hg',    
}
```
