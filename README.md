# README

This is an example project for using Dokcer and docker-compose.

Run the following command to start the services:

```sh
docker-compose up --build -d
```

Then create the database:

```sh
docker-compose exec web bash -c 'rails db:create && rails db:migrate'
```

You can view the app on [localhost:3000](http://localhost:3000/).

Remove containers:

```sh
docker-compose down
```