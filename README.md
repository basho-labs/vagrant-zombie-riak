# vagrant-zombie-riak


This is a self-contained demo that spins up the [Zombie Inverted-Index demo](https://github.com/drewkerrigan/riak-inverted-index-demo) on the same VM as the [Vagrant Ruby Client](https://github.com/basho-labs/riak-ruby-vagrant) environment. 

While this app is well-designed, this project is not designed for production use. **Do not use this in production.**

### Read More

* Read the [Riak Zombie Revival blog post](http://basho.com/posts/technical/reviving-the-zombie-app-for-oscon/)
* See [the app live on AWS](http://54.147.200.141:8080/) (which uses our [2.1.1 AMI](https://aws.amazon.com/marketplace/pp/B00YFZ60X2/ref=sp_mpg_product_title?ie=UTF8&sr=0-2))

## Getting Started

**Note on Internets**: An Internet connection is required to run `vagrant up`. If you want to spin up the demo and save it for later, run the initial `vagrant up` mentioned below and then `vagrant suspend` to save it. You can run `vagrant resume` when you're ready to demo (no connection required).

0. If you haven't got it, install [Vagrant](http://vagrantup.com).
1. If you haven't got it or another Vagrant-supported virtualization
   package, install [VirtualBox](https://www.virtualbox.org).
1. Clone this repo: `git clone https://github.com/basho-labs/vagrant-zombie-riak.git`
2. `cd` into this repo: `cd vagrant-zombie-riak`
3. Run `vagrant up` to start the VM build process.
4. Wait a while.
3. Riak KV is now running in a virtual machine, listening for protobuffs on localhost:17017, and HTTP at http://localhost:17018/ 
4. The fully-functional zombie demo is available at **http://localhost:8080/**


## Configuration Notes

This instance has:

* Takes up 2GB of memory to support Riak and the zombie app. 1GB didn't cut it.
* [Yokozuna full-text search](https://github.com/basho/yokozuna) (or "yz") enabled. I use this to test
  the client's yz support, as well as [other gems](https://github.com/bkerley/riak-yz-query)
  that also use yz search. To support yz, the Oracle JVM is installed. Yokozuna uses the "yokozuna" bucket
  type.
* [Active Anti-Entropy](http://docs.basho.com/riak/latest/theory/concepts/glossary/#Active-Anti-Entropy-AAE-) 
  enabled. This has a bit of disk and IO overhead, but is necessary for yz.
* [LevelDB backend](http://docs.basho.com/riak/latest/ops/advanced/backends/leveldb/) configured;
  2i works, kv and yz data persist. The disk usage may grow, in which case, destroy and re-up the
  VM.
* [allow_mult](http://docs.basho.com/riak/latest/theory/concepts/Vector-Clocks/#Siblings) enabled
  by default, because I need to test how the client handles sibling resolution and CRDTs.
* Bucket types for Set, Counter, and Map CRDTs. They're called "sets", "counters", and "maps" respectively.
* [Security](http://docs.basho.com/riak/latest/ops/running/authz/) for protocol buffers is configured but
  not completely enabled. The configured user has the username "user" and the password "password". There's
  also "certuser" identified by a client cert (which ships with the 
  [ruby-client](https://github.com/basho/riak-ruby-client/tree/master/spec/support/certs) ).

###Enabling and Disabling Security

Enabling:
```
your-machine> vagrant ssh
Welcome to Ubuntu 12.04.1 LTS (GNU/Linux 3.2.0-29-virtual x86_64)

vagrant@precise64:~$ sudo riak-admin security enable
Enabled
```

Disabling:
```sh
your-machine> vagrant ssh
Welcome to Ubuntu 12.04.1 LTS (GNU/Linux 3.2.0-29-virtual x86_64)

vagrant@precise64:~$ sudo riak-admin security disable
Disabled
```

## Contributing

Review the details in [CONTRIBUTING.md](CONTRIBUTING.md) in order to give back to this project.

Note that projects that extend on this repository will be linked to in the [vagrant-riak-meta](https://github.com/basho-labs/vagrant-riak-meta). Share them via issues on [the Community repo](https://github.com/basho-labs/the-riak-community)!


## License and Authors

* [Bryce Kerley](https://github.com/bkerley)
* [Drew Kerrigan](https://github.com/drewkerrigan)
* [Matt Brender](https://github.com/mjbrender)

Copyright (c) 2015 Basho Technologies, Inc.

Licensed under the Apache License, Version 2.0 (the "License"); you may
not use this file except in compliance with the License. You may obtain
a copy of the License at

[http://www.apache.org/licenses/LICENSE-2.0](http://www.apache.org/licenses/LICENSE-2.0)

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or
implied.

See the License for the specific language governing permissions and
limitations under the License.
