# Tagger

A small application to add tags to your GitHub repositories.

## External requirements

If you want to make real requests to the Github API, keep in mind an API Key is necessary. To create a new one, use the following steps:

- Go to [GitHub's Personal Access Tokens](https://github.com/settings/tokens) management page
- Create a new token with the `public_repo` scope
- Save the token in a secure palce - you'll only be able to do so now

This token should be exported as the `GITHUB_TOKEN` environment variable before running the app.

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
- Export your configuration according to the `External requirements` section
- Start Phoenix with `iex -S mix phx.server`
- Enjoy your interactive session

Direct access for usage with your preffered tools will be available on:

- Server app's endpoint: `localhost:4000`
- Database server: `localhost:5678`

