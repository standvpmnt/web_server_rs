FROM lukemathwalker/cargo-chef:latest-rust-<ADD_VERSION_HERE>-bullseye as chef
WORKDIR /app
RUN apt update && apt install lld clang -y

FROM chef as planner
COPY . .
RUN cargo chef prepare --recipe-path recipe.json

FROM chef as builder
COPY --from=planner /app/recipe.json recipe.json
RUN cargo chef cook --release --recipe-path recipe.json
COPY . .
ENV SQLX_OFFLINE true
RUN cargo build --release --bin <BINARY_TARGET_NAME_FROM_CARGO_TOML>

FROM debian:bullseye-slim AS runtime
WORKDIR /app
RUN apt-get update -y \
    && apt-get install -y --no-install-recommends openssl ca-certificates \
    && apt-get autoremove -y \
    && apt-get clean -y \
    && rm -rf /var/lib/apt/lists/*
COPY --from=builder /app/target/release/<TARGET_DEFINED_ABOVE> <NAME_OF_BINARY>
COPY configuration configuration
ENV APP_ENVIRONMENT production
ENTRYPOINT ["./<NAME_OF_BINARY>"]

