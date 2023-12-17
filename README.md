# Rust webserver template

This template is based on the setup provided in Zero2Prod with a few tweaks to
the dependencies.
This repository is planned to have the template be available for 2 frameworks
actix-web because that is the default in the Zero2Prod book and axum as the
second web-server. actix-web version is available in the main branch and the
axum version is maintained in the `axum` branch.

## Basics

### Versions
To check your version of rust toolchain run `rustc --version` and
`cargo --version`.

### Faster linking
This project uses lld from the llvm project for faster linking. Ensure you have
lld installed on your system. To install review the documentation in the
`.cargo/config.toml` file.

### Compile, Test, Run loop
For quicker feedback loops of compile, test and run use the tool `cargo-watch`,
to install the tool run `cargo install cargo-watch`. To run this tools execute
the command `cargo watch -x check -x test -x run` which will check, test and
then run the code.

### Project binary and library
To understand about the binary and library modules in the project review the
`[[bin]]` and `[lib]` section of the `cargo.toml` file.

### Code coverage
For code coverage, you can check it locally by installing tarpaulin `cargo
install cargo-tarpaulin`. This is part of the github actions documented in
the project and hence will be used by the github actions anyways.

### Static code analysis
This project suggests using `clippy` for static analysis of the code. To run
clippy execute `cargo clippy`. In order to bypass a particular warning add
`#[allow(clippy::lint_name)]` to the top of the affected code block.
Additionally, if this is something that is impacting the entire project, add
the allow rule into the clippy.toml file.

### Formatting
To ensure standard formatting, it is strongly advised to use the standard
formatter provided by the rust toolchain. This can be executed by running
`cargo fmt`.

### Auditing for vulnerabilities
To check for vulnerabilities in the dependencies it is advised to use the tool
audit which can be installed using `cargo install cargo-audit` and can be
executed using `cargo audit`.

### Github actions
The project has a set of github actions which are setup based on the template
provided in the Zero2Prod book (reference pg. 10 "Ready-to-go CI pipelines").

## Project structure


## Setup

### Database
The project relies on a postgres database to be running, here there are 2
approaches to make it work.
1. If there is a postgres server running, the credentials for connecting to
the server can be defined as environment variables indicated on line number 18
through 25 in [init_db.sh](./scripts/init_db.sh) file, and ensure to set the
`SKIP_DOCKER` environment variable indicated on line number 28 to any value.
2. If there is no postgres server running, the script will start a postgres
container using docker, hence this step requires a pre-requisite of docker to
be available on the system to work. To get the database created and migrated
update the default values or set the environment vriables indicated on line
number 18 through 25 in [init_db.sh](./scripts/init_db.sh) file.

After updating the appropriate lines and/or setting the environment variables,
make sure the script has execute permission by running `chmod +x ./scripts/init_db.sh`
and then run the script by running `./scripts/init_db.sh` in shell.

Presently, this script may not be able to pick up env variables which you set
using the `export` command in the shell where the script is being executed, this
is probably due to the shebang at the top, this is indicating usr/bin/env

_NOTE_
This project uses sqlx and it is assumed that `sqlx-cli` is available on the
system to do the development related actions.

#### Creating a migration
To create a migration execute the command, `sqlx migrate add <description>`,
this will create a simple migration file, if `up` and `down` style of migration
files is preferred the command to be executed is instead
`sqlx migrate add -r <description>`, _note only style either single migration or
up and down pattern can be used_

### Dockerfile
After creating a project with this template, update the [Dockerfile](./Dockerfile)
with the following:
1. Correct rust version based on the one being used for development (line# 1)
2. Correct binary name as indicated in the Cargo.toml file, this name (line# 14)
should match one of the names defined in binary targets in [Cargo.toml](./Cargo.toml)
3. Update the name of the binary to be copied from the builder step, this should
match the name specified in point 2 above and then the name of the binary that
will be executed in the container on line#23 and line#26.

### Commented files
There is a file called email_client.rs which is included in the repository for
reference. This is not a part of the code required to get this setup running.
However, this file is included as it represents an important pattern which is
to be used when working with the application of providing a client as an
argument to the `Application` at the time of startup. The way to wire this
client to the application is included in the code in the [startup.rs file](./src/startup.rs)
and is also commented out for easier removal in the future.
Similarly, in the tests folder, there is a commented file [newsletter.rs](./tests/api/newsletter.rs)
to show the pattern to be used when writing tests.
