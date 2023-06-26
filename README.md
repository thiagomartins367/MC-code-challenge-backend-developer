# Multiverse Travels Booker API

This documentation specifies the code for the Multiverse Travels Booker API, intended to manage travel plans in the Rick and Morty universe.

On the home page path `/` you can see the documentation of the API features in
[Swagger](https://swagger.io/).

## Installation and Usage
NOTE: It is necessary to have installed the [Crystal](https://crystal-lang.org) language
and the [MySQL](https://dev.mysql.com/downloads/mysql) database management system.

1. Install dependencies
```
# Run command
shards install
```

2. Build application
```
# Run command
crystal build --static --release src/api.cr -o bin/api
```

3. Configuring `Jennifer ORM` database connection settings
```
# File path: ./config/database.yml

default: &default
  user: # database access user
  password: # user password
  adapter: mysql
  skip_dumping_schema_sql: true

# ...

production:
  <<: *default
  db: multiverse_travels_booker # database name
  host: # connection host (Ex: localhost)
  port: # Connection port (Ex: "3306") [Warning: Port needs to be in `String` format]

# ...

```

4. Creating the database and tables
NOTE: The database and table creation commands use the commands listed in the `Makefile` file.

```
# Run command to create the database:
make sam db:create

# Then run command to create the database tables:
make sam db:migrate

# At the end, check that the database and tables were created
``` 

4. Start API
```
# Run command
KEMAL_ENV=production APP_ENV=production ./bin/api

# The `KEMAL ENV` and `APP_ENV` variables are required to use the production version of the API.
```

5. Check logs in terminal
```
# If everything went well then you will see the logs below:

# ...
# [production] Kemal is ready to lead at http://0.0.0.0:3000
# ...
```

## Usage in Docker 

If you have both [Docker](https://www.docker.com)
and [Docker compose](https://docs.docker.com/compose/install) installed,
you can save a lot of effort.

To start the API in the Docker, just run 1 command:
```
# Run command
docker-compose up -d

# Container log:
# ...
# [production] Kemal is ready to lead at http://0.0.0.0:3000
# ...
```
Once the containers are working the API can be used.

## Development

To develop new features or refactor it is recommended to use Docker, as it provides an isolated and properly configured environment in the `docker-compose.dev.yml` file.

1. Definindo variáveis de ambiente e configurações de conexão
  - Create a `./db/.env.development.local` file using the `./db/.env.development.local.example` file.
  - Set a password for the `root` database user in the `MYSQL_ROOT_PASSWORD` environment variable which will be used in the database container.
  - Create a `./.env.development.local` file using the `./.env.development.local.example` file.
  - Set a value for each variable listed in the file.
  - Create and configure the `Jennifer ORM` connection file in `./config/database.yml`.
```
# File path: ./config/database.yml

default: &default
  user: root
  password: # user password (Same as defined in MYSQL_ROOT_PASSWORD variable)
  adapter: mysql
  skip_dumping_schema_sql: true

# ...

development:
  <<: *default
  db: dev_multiverse_travels_booker
  host: dev_db_multiverse_travels_booker # Container Docker
  port: "3306" # Connection port [Warning: Port needs to be in `String` format]

# ...

```

2. Starting the development environment

  - To create the development Docker environment run the command below:
```
# Run command
docker-compose -f docker-compose.dev.yml up -d
```
After this process, both the API and the database will be working.
NOTE: An initial command `seed` is run every time containers are built to populate the database with data for development.
NOTE: The use of the `make` scripts/commands listed in the `Makefile` file is recommended in the development environment to speed up the development process.

<!-- ## Contributing

1. Fork it (<https://github.com/your-github-user/6c428e8aeb720fd6309b7196f34aab636f27a3c2/fork>)
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request -->

## Contributors

- [THIAGO MARTINS](https://github.com/thiagomartins367) - creator and maintainer
