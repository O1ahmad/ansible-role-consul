<p><img src="https://www.consul.io/assets/images/og-image-6ef0ad8b.png" alt="grafana logo" title="grafana" align="right" height="60" /></p>

Ansible Role :satellite: :low_brightness: Consul
=========
[![Galaxy Role](https://img.shields.io/ansible/role/45968.svg)](https://galaxy.ansible.com/0x0I/grafana)
[![Downloads](https://img.shields.io/ansible/role/d/45968.svg)](https://galaxy.ansible.com/0x0I/grafana)
[![Build Status](https://travis-ci.org/0x0I/ansible-role-consul.svg?branch=master)](https://travis-ci.org/0x0I/ansible-role-consul)

**Table of Contents**
  - [Supported Platforms](#supported-platforms)
  - [Requirements](#requirements)
  - [Role Variables](#role-variables)
      - [Install](#install)
      - [Config](#config)
      - [Launch](#launch)
      - [Uninstall](#uninstall)
  - [Dependencies](#dependencies)
  - [Example Playbook](#example-playbook)
  - [License](#license)
  - [Author Information](#author-information)

Ansible role that installs and configures Consul: a service discovery, mesh and configuration control plane and networking tool.

##### Supported Platforms:
```
* Debian
* Redhat(CentOS/Fedora)
* Ubuntu
```

Requirements
------------
Requires the `unzip/gtar` utility to be installed on the target host. See ansible `unarchive` module [notes](https://docs.ansible.com/ansible/latest/modules/unarchive_module.html#notes) for details.

Role Variables
--------------
Variables are available and organized according to the following software & machine provisioning stages:
* _install_
* _config_
* _launch_
* _uninstall_

#### Install

`consul`can be installed using compressed archives (`.tar`, `.zip`), downloaded and extracted from various sources, or built from *git* source.

_The following variables can be customized to control various aspects of this installation process, ranging from software version and source location of binaries to the installation directory where they are stored:_

`consul_user: <service-user-name>` (**default**: *consul*)
- dedicated service user and group used by `consul` for privilege separation (see [here](https://www.beyondtrust.com/blog/entry/how-separation-privilege-improves-security) for details)

`install_type: <archive | source>` (**default**: archive)
- **archive**: currently compatible with both **tar and zip** formats, installation of Consul via compressed archives results in the direct download of its component binaries, consisting of the `consul` server and client agent, from the specified archive url.

  **note:** archived installation binaries can be obtained from the official [releases](https://www.consul.io/downloads.html) site or those generated from development/custom sources.

- **source**: build *consul server and client* binaries from source. This installation process consists of cloning the github hosted [repository](https://github.com/hashicorp/consul/releases) and building from source code using `make` directives. See [here](https://www.consul.io/docs/install/index.html#compiling-from-source) for more details on building from source.

`install_dir: </path/to/installation/dir>` (**default**: `/opt/consul`)
- path on target host where the `consul` binaries should be extracted to.

`archive_url: <path-or-url-to-archive>` (**default**: see `defaults/main.yml`)
- address of a compressed **tar or zip** archive containing `consul` binaries. This method technically supports installation of any available version of `consul`. Links to official versions can be found [here](https://releases.hashicorp.com/consul/).

`archive_checksum: <path-or-url-to-checksum>` (**default**: see `defaults/main.yml`)
- address of a checksum file for verifying the data integrity of the specified archive. While recommended and generally considered a best practice, specifying a checksum is *not required* and can be disabled by providing an empty string (`''`) for its value.

`checksum_format: <string>` (**default**: see `sha512`)
- hash algorithm used for file verification associated with the specified archive or package checksum. Reference [here](https://en.wikipedia.org/wiki/Cryptographic_hash_function) for more information about *checksums/cryptographic* hashes.

`archive_options: <untar-or-unzip-options>` (**default**: `[]`)
- list of additional unarchival arguments to pass to either the `tar` or `unzip` binary at runtime for customizing how the archive is extracted to the designated installation directory. See [<man tar>](https://linux.die.net/man/1/tar) and [<man unzip>](https://linux.die.net/man/1/unzip) for available options to specify, respectively.

`git_url: <path-or-url-to-git-repo>` (**default**: see `defaults/main.yml`)
- address of `consul` git repository. Address can reference the [Github](https://github.com/hashicorp/consul) site address or custom source hosted on an alternate git hosting site.

`git_version: <string>` (**default**: `v1.6.2`)
- version of the *Git* repository to check out. This can be the literal string HEAD, a branch name or a tag name.

`go_autoinstall: <true|false>` (**default**: `false`)
- automatically install the specified version of Go packages and binaries. Useful when installing from source which requires `go` as a part of its build process

`go_url: <path-or-url-to-archive>` (**default**: see `defaults/main.yml`)
- address of a compressed **tar or zip** archive containing `go` binaries or source for compilation. This method technically supports installation of any available version of `go`. Links to official versions can be found [here](https://golang.org/dl/). *ONLY* relevant when installing on **non-Ubuntu** linux distributions.

`go_install_dir: </path/to/install/dir>` (**default**: `/usr/local`)
- path on target host where the `go` binaries should be extracted to.

#### Config

...*description of configuration related vars*...

#### Launch

`go_exe_dir: </path/to/exe/dir>` (**default**: `<platform_dependent>`)
- path on target host where the `go` binaries should be extracted to.

#### Uninstall

...*description of uninstallation related vars*...

Dependencies
------------

...*list dependencies*...

Example Playbook
----------------
default example:
```
- hosts: all
  roles:
  - role: 0xOI.<role>
```

License
-------

Apache, BSD, MIT

Author Information
------------------

This role was created in 2019 by O1.IO.
