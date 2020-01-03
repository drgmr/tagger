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

## Known limitations and possible improvements

- The process of ensuring a local copy of a repository is up to date checks the database multiple times - we could use some form of batching for those queries
- The routes for browsing starred respositories are not obvious from a simple route listing - the documentation is necessary for an user to discover that
- There's no access control or user management
- A deployment process is not yet completely set up. Ideally a release would use the running environment's configuration to access external resources (DNS for database access, runtime environment variables for secrets, etc)
- There's no paging support in place for browsing repositories yet
- Error handling is not ideal at the Web API level. This still needs a better mapping of possible errors with proper specs - then the fallback controller should be able to handle with more precision each error case.
- There's some slight duplication of code - building better testing facilities would fix that.
- Bluebird is not the best documentation tool since it makes you copy and mix router and controller data if you wan to use all of it's metadata - but the concept of documenting by tests is great.
- Instructions + NodeJS support on Docker setup is missing. Short version: `npm i -g aglio` / `mix test` / `mix bird.gen.docs`.