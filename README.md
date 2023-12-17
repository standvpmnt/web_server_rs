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

After updating the appropriate lines and/or setting the environment variables
run the script by running `./scripts/init_db.sh` in shell.
