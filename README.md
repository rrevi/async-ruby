# async-ruby
Playground to learn all things related to asynchronous Ruby (influenced by https://brunosutic.com/blog/async-ruby)

## Requirements
- Ruby 3.0+ (use rbenv to install and use)
- Install gems:
  - gem install async-http
  - gem install httparty
  - gem install redis
  - gem install net-ssh
  - gem install sequel
  - gem install pg
- A running Postgres database instance on port 5432
  - Follow the instructions at the [official Postgres website](https://www.postgresql.org/download/)
- A runnning redis server instance on port 6379
  - You can quickly set this up via [redis on Docker](https://hub.docker.com/_/redis):
  ```
  docker pull redis
  docker run --name async-ruby-redis -p 6379:6379 -d redis
  ```
- A running linux machine instance with a ssh server listening on port 22
  - Use of [this Vagrant projects repo](https://github.com/oracle/vagrant-projects) is one way to quickly set this up (setup the linux vm with a bridged network interface to use the ip address of this interface in the advanced+ scripts)
  - once the linux vm is up and running, ssh into it and create a user with the same user name as that on your workstation
  - ssh copy your workstation user public key to the linux vm (e.g. `ssh-copy-id -i ~/.ssh/id_rsa.pub Rafael@192.168.1.22`)
  - make sure to run the `ssh-add` command in your workstation terminal to add your identity (keys) to your ssh client