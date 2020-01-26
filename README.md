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
- address of a checksum file or actual checksum for verifying the data integrity of the specified archive. While recommended and generally considered a best practice, specifying a checksum is *not required* and can be disabled by providing an empty string (`''`) for its value.

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

Consul supports specification of multiple configuration files or definitions for controlling various aspects of an agent's behavior. These definitions are expected to be expressed in either `JSON` or `HCL` format and to adhere to the syntax framework and rules outlined in *Consul's* official docs and as determined by the community. Each of these configurations can be expressed using the `consul_configs` hash, which contains a list of various Consul agent *configuration options*, *config-entries*, *service registrations* and *check* or service healthcheck directives.

These hashes contain a list of structures specific to each configuration type for declaring the desired agent settings to be rendered in addition to common amongst them all, `:name, :path and :config` which specify the name and path of the configuration file to render and a hash of the configuration to set. See [here](https://www.consul.io/docs/agent/config_entries.html) for more details as well as a list of supported options for each configuration type.

The following provides a reference for a more in-depth explanation in addition to examples of each.

`[consul_configs: <entry>:] name: <string>` (**default**: *required*)
- name of the configuration file to render on the target host (excluding the file extension)

`[consul_configs: <entry>:] type: <json|hcl>` (**default**: *json*)
- type or format of the configuration file to render. Configuration can be either in JSON or [HCL](https://github.com/hashicorp/hcl#syntax) format.

`[consul_configs: <entry>:] path: </path/to/config>` (**default**: */etc/consul.d*)
- path of the configuration file to render on the target host

  **Note:** When loading configuration, Consul loads the configuration from files and directories in lexical order. Configuration specified later will be merged into configuration specified earlier. In general, "merge" results in the later version overriding the earlier. In some cases, such as event handlers, merging appends the handlers to the existing configuration.

`[consul_config: <entry>:] config: <JSON>` (**default**: )
- specifies parameters that manage various aspects of a consul agent's operations

[Reference here](https://www.consul.io/docs/agent/options.html) for a list of supported configuration options.

##### Example

 ```yaml
  consul_configs:
    - name: example-config
      path: /example/path
      config:
        data_dir: /var/lib/consul
        log_level: debug
  ```
  
##### Service Definitions

Agents provide a simple service definition format to declare the availability of a service and to potentially associate it with a health check. Each service definition must include a name and may optionally provide an *id, tags, address, meta, port, enable_tag_override, and check*. See [here](https://www.consul.io/docs/agent/services.html) for more details regarding these optional arguments and suggestions on their usage.

`[consul_config: <entry>: config: service:] <JSON>` (**default**: )
- specifies parameters that manage Consul service registration

##### Example

 ```yaml
  consul_configs:
    - name: example-service
      # type: json
      # path: /etc/consul.d
      config:
        service:
          id: redis
          name: redis
          tags: ['prod']
          port: 8000
          enable_tag_override: false
          checks:
            - args: ["/usr/local/bin/check_redis.py"],
              interval: 10s
  ```
  
##### Config Entries

Configuration entries can be created to provide cluster-wide defaults for various aspects of Consul. Every configuration entry has at least two fields: Kind and Name. Those two fields are used to uniquely identify a configuration entry. When put into configuration files, configuration entries can be specified as HCL or JSON objects using either snake_case or CamelCase for key names.

###### Service Defaults

Service Defaults, one of the five config entry objects supported by Consul, control default global values for a service, such as its protocol, MeshGateway topology settings, list of paths to expose through Envoy and ACLs or access-control-lists. Specification of these options are expected to be defined within the `config : config_entries : bootstrap` hash list. See [here](https://www.consul.io/docs/agent/config-entries/service-defaults.html) for more details regarding available configuration settings and suggested usage.

`[consul_config: <entry>: config: config_entries : bootstrap:] <JSON list entry>` (**default**: [])
- specifies parameters that manage default settings for a particular service group 

##### Example

 ```yaml
  consul_configs:
    - name: example-api-defaults
      config:
        config_entries:
          bootstrap:
            - Kind: service-defaults
              Name: example-api
              Protocol: http
  ```
  
###### Proxy Defaults

Service Defaults, one of the five config entry objects supported by Consul, control default global values for a service, such as its protocol, MeshGateway topology settings, list of paths to expose through Envoy and ACLs or access-control-lists. Specification of these options are expected to be defined within the `config : config_entries : bootstrap` hash list. See [here](https://www.consul.io/docs/agent/config-entries/service-defaults.html) for more details regarding available configuration settings and suggested usage.

`[consul_config: <entry>: config: config_entries : bootstrap:] <JSON list entry>` (**default**: [])
- specifies parameters that manage default settings for a particular service group 

##### Example

 ```yaml
  consul_configs:
    - name: example-api-defaults
      config:
        config_entries:
          bootstrap:
            - Kind: service-defaults
              Name: example-api
              Protocol: http
  ```

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
