# Corn Dog
[ ![Codeship Status for jmennick/cornDog](https://app.codeship.com/projects/94d87570-cafa-0134-24ca-36c4adfc6db3/status?branch=master)](https://app.codeship.com/projects/199789)

A web-based accounting software.

### Account Access
The account info that works is as follows:
```
username: jdoe@corndog.herokuapp.com
password: 12345
```

### Development Dependencies
In order to install, you will need the following:
* [Docker](https://www.docker.com): used to spin up supporting services
* [Ruby](https://www.ruby-lang.org/en/): the programming language used to specify the application (ensure this is the same as the version specified in [.ruby-version](.ruby-version))
* [Bundler](http://bundler.io): used to download packaged gems
* [NodeJS](https://nodejs.org/en/): used to serve the client-side

### Installation
After you have installed these dependencies, you should run the folowing:
```shell
$ bundle install
$ cd client
$ npm install
$ cd ..
```
This should get all of the necessary libraries for you.

### Run Tests
```shell
$ guard -g test
```
(NOTE: tests will run automatically when corresponding files change, hitting return will run all tests)

### Run Development Server
```shell
$ guard -g dev
```
(NOTE: server will run at [localhost:3000](http://localhost:3000), this will not be available on your local network)

### Run Nuxt Client (on its own)
```shell
$ cd client
$ npm run dev
```

### Lucidchart Folder (for documentation)
https://www.lucidchart.com/invitations/accept/b6110306-ce30-427d-aa75-27cd6df4873b
