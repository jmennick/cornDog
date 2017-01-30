# Corn Dog
A web-based accounting software.

### Development Dependencies
In order to install, you will need the following:
* [Docker](https://www.docker.com): used to spin up supporting services
* [Ruby](https://www.ruby-lang.org/en/): the programming language used to specify the application (ensure this is the same as the version specified in [.ruby-version](.ruby-version))
* [Bundler](http://bundler.io): used to download packaged gems

### Test Startup Sequence
Start Dependent Services:
```shell
$ docker-compose up
```
Start Application Preloader:
```shell
$ spring server
```
Start Test Runner:
```shell
$ guard
```
(note: you will want to start these in separate tabs/windows in your terminal)

### Alternate Setup
Start Dependent Services:
```shell
$ docker-compose up -d
```
Start Application Preloader:
```shell
$ spring server -d
```
Start Test Runner:
```shell
$ guard
```
Stop Application Preloader:
```shell
$ spring Stop
```
Stop Dependent Services:
```shell
$ docker-compose down
```
