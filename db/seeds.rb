# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

Client::Client.create(name: 'Sony')
Client::Client.create(name: 'Mopet')
Client::Client.create(name: 'Recorrido')

Client::Schedule.create(start: '8', end: '20', day_of_week: 'monday', client_clients_id: 1)
Client::Schedule.create(start: '8', end: '20', day_of_week: 'monday', client_clients_id: 2)
Client::Schedule.create(start: '8', end: '9', day_of_week: 'tuesday', client_clients_id: 1)
Client::Schedule.create(start: '8', end: '9', day_of_week: 'wednesday', client_clients_id: 1)
Client::Schedule.create(start: '8', end: '9', day_of_week: 'thursday', client_clients_id: 1)

Client::Schedule.create(start: '19', end: '24', day_of_week: 'monday', client_clients_id: 3)
Client::Schedule.create(start: '19', end: '24', day_of_week: 'tuesday', client_clients_id: 3)
Client::Schedule.create(start: '19', end: '24', day_of_week: 'wednesday', client_clients_id: 3)
Client::Schedule.create(start: '19', end: '24', day_of_week: 'thursday', client_clients_id: 3)
Client::Schedule.create(start: '19', end: '24', day_of_week: 'friday', client_clients_id: 3)
Client::Schedule.create(start: '10', end: '24', day_of_week: 'saturday', client_clients_id: 3)
Client::Schedule.create(start: '10', end: '24', day_of_week: 'sunday', client_clients_id: 3)

Worker::Worker.create(name: 'John', client: Client::Client.first, color: 'pink')
Worker::Worker.create(name: 'Jane', client: Client::Client.first, color: 'blue')
Worker::Worker.create(name: 'Jack', client: Client::Client.first, color: 'green')
Worker::Worker.create(name: 'Jill', client: Client::Client.first, color: 'purple')

Worker::Worker.create(name: 'Gabriel', client: Client::Client.second, color: 'purple')

Worker::Worker.create(name: 'Ernesto', client: Client::Client.third, color: 'orange')
Worker::Worker.create(name: 'Barbara', client: Client::Client.third, color: 'purple')
Worker::Worker.create(name: 'Benjamin', client: Client::Client.third, color: 'blue')

# week 1
Worker::Schedule.create(time: '2022-08-08 9:00:00', worker: Worker::Worker.first)
Worker::Schedule.create(time: '2022-08-08 10:00:00', worker: Worker::Worker.first)
Worker::Schedule.create(time: '2022-08-08 11:00:00', worker: Worker::Worker.first)
Worker::Schedule.create(time: '2022-08-08 12:00:00', worker: Worker::Worker.first)
Worker::Schedule.create(time: '2022-08-08 13:00:00', worker: Worker::Worker.first)
Worker::Schedule.create(time: '2022-08-08 14:00:00', worker: Worker::Worker.first)
Worker::Schedule.create(time: '2022-08-08 15:00:00', worker: Worker::Worker.first)

Worker::Schedule.create(time: '2022-08-08 13:00:00', worker: Worker::Worker.second)
Worker::Schedule.create(time: '2022-08-08 14:00:00', worker: Worker::Worker.second)
Worker::Schedule.create(time: '2022-08-08 15:00:00', worker: Worker::Worker.second)
Worker::Schedule.create(time: '2022-08-08 16:00:00', worker: Worker::Worker.second)
Worker::Schedule.create(time: '2022-08-08 17:00:00', worker: Worker::Worker.second)

Worker::Schedule.create(time: '2022-08-08 17:00:00', worker: Worker::Worker.third)
Worker::Schedule.create(time: '2022-08-08 18:00:00', worker: Worker::Worker.third)
Worker::Schedule.create(time: '2022-08-08 19:00:00', worker: Worker::Worker.third)

Worker::Schedule.create(time: '2022-08-09 8:00:00', worker: Worker::Worker.fourth)

Worker::Schedule.create(time: '2022-08-10 8:00:00', worker: Worker::Worker.fourth)

Worker::Schedule.create(time: '2022-08-11 8:00:00', worker: Worker::Worker.fourth)

# week 2
Worker::Schedule.create(time: '2022-08-15 9:00:00', worker: Worker::Worker.first)
Worker::Schedule.create(time: '2022-08-15 10:00:00', worker: Worker::Worker.first)
Worker::Schedule.create(time: '2022-08-15 11:00:00', worker: Worker::Worker.first)
Worker::Schedule.create(time: '2022-08-15 12:00:00', worker: Worker::Worker.first)
Worker::Schedule.create(time: '2022-08-15 13:00:00', worker: Worker::Worker.first)
Worker::Schedule.create(time: '2022-08-15 14:00:00', worker: Worker::Worker.first)
Worker::Schedule.create(time: '2022-08-15 15:00:00', worker: Worker::Worker.first)

Worker::Schedule.create(time: '2022-08-15 13:00:00', worker: Worker::Worker.second)
Worker::Schedule.create(time: '2022-08-15 14:00:00', worker: Worker::Worker.second)
Worker::Schedule.create(time: '2022-08-15 15:00:00', worker: Worker::Worker.second)
Worker::Schedule.create(time: '2022-08-15 16:00:00', worker: Worker::Worker.second)
Worker::Schedule.create(time: '2022-08-15 17:00:00', worker: Worker::Worker.second)

Worker::Schedule.create(time: '2022-08-15 17:00:00', worker: Worker::Worker.third)
Worker::Schedule.create(time: '2022-08-15 18:00:00', worker: Worker::Worker.third)
Worker::Schedule.create(time: '2022-08-15 19:00:00', worker: Worker::Worker.third)

Worker::Schedule.create(time: '2022-08-16 8:00:00', worker: Worker::Worker.fourth)

Worker::Schedule.create(time: '2022-08-17 8:00:00', worker: Worker::Worker.fourth)

Worker::Schedule.create(time: '2022-08-18 8:00:00', worker: Worker::Worker.fourth)
