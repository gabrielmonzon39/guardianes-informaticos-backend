# Full Stack Developer Test

This is the backend part of the test. 

## System dependencies
---
To get this application up and running you need to have docker installed.
For more information on docker please visit [https://www.docs.docker.com/](https://www.docs.docker.com/)

## Set up
---
Because this application was developed using docker, all configurations come ready to use. All you need to do is run the following command:

```bash
docker-compose build
```
It may take some time to build the application. Once it is done you can access the API at the following url: http://localhost:3000

## Running the application
---
To run the application you need to run the following command:

```bash
docker-compose up
```
Or you can run the following command to run the application in the background:

```bash
docker-compose up -d
```

## Database creation and initialization
---
Please make sure that the application is running before creating the database.


Run the following commands to create and initialize the database:

```bash
docker exec -it rails_recorrido rails db:setup
```


## How to run the test suite
---
To run the test suite you need to run the following command:

```bash
docker exec -it rails_recorrido rspec
```
