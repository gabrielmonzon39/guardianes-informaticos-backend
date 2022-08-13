# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

Client::Client.create(name: 'Sony')
Client::Schedule.create(start: '8', end: '20', day_of_week: 'monday', client_clients_id: 1)
Worker::Worker.create(name: 'John', client: Client::Client.first)
Worker::Schedule.create(time: '2022-08-08 10:00:00', worker: Worker::Worker.first)
