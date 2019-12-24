# Tagger

A small application to add tags to your GitHub repositories.

## Tooling requirements

You'll need a recent version of `docker` and `docker-compose` - more information available on the official documentation:

- [Installing Docker](https://docs.docker.com/install/)
- [Installing docker-compose](https://docs.docker.com/compose/install/)

## Running the development server

After installing the tooling requirements, do the following:

- Run `docker-compose up` (or `docker-compose up -d` to detach from Postgres' logs)
- Attach a terminal session to the server container with `docker exec -it tagger-server bash`
- `cd` into `/opt/app`
- Install dependencies with `mix deps.get`
- Create and migrate your database with `mix ecto.setup`
- Start Phoenix with `iex -S mix phx.server`
- Enjoy your interactive session

Direct access for usage with your preffered tools will be available on:

- Server app's endpoint: `localhost:4000`
- Database server: `localhost:5678`

