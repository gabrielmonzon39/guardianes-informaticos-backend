# Full Stack Developer Test

This is the backend part of the test. This was built using Ruby on Rails 7, PostgreSQL, and Docker.

## System dependencies
To get this application up and running you need to have docker installed.
For more information on docker please visit [https://www.docs.docker.com/](https://www.docs.docker.com/)

## Set up
Because this application was developed using docker, all configurations come ready to use. All you need to do is run the following command:

```bash
docker-compose build
```
It may take some time to build the application. 

## Running the application
To run the application you need to run the following command:

```bash
docker-compose up
```
Or you can run the following command to run the application in the background:

```bash
docker-compose up -d
```

Once it is done you can access the API at the following url: http://localhost:3000

## Database creation and initialization
Please make sure that the application is running before creating the database.


Run the following commands to create and initialize the database:

```bash
docker exec -it rails_recorrido rails db:setup
```


## How to run the test suite
To run the test suite you need to run the following command:

```bash
docker exec -it rails_recorrido rspec
```

## Next steps
Now you can go and check the frontend part of the application in [this repository](https://github.com/gabrielmonzon39/guardianes-informaticos-frontend)

## Demo
For a quick demo of the application you can check the [following video](https://drive.google.com/file/d/18Rj_sbIpGPikFD1TGCa2V19Wq_hjDJHH/view?usp=sharing)