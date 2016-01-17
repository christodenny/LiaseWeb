require 'sinatra'
require 'sinatra/activerecord'
require 'json'

db = URI.parse('postgres://oaafdlhwmkznte:mP2aHxLDrp7Xz_5Hy7KQo_hpBC@ec2-54-225-165-132.compute-1.amazonaws.com:5432/d58tgju84l2ipv')

ActiveRecord::Base.establish_connection(
	:adapter => 'postgresql',
	:host => db.host,
	:username => db.user,
	:password => db.password,
	:database => db.path[1..-1],
	:encoding => 'utf8'
)

class Event < ActiveRecord::Base
	self.table_name = "events"
end

class People_Event < ActiveRecord::Base
	self.table_name = "people_events"
end

class Person < ActiveRecord::Base
	self.table_name = "people"
end

class Team < ActiveRecord::Base
	self.table_name = "teams"
end

class Contact < ActiveRecord::Base
	self.table_name = "contacts"
end


get "/" do
	"hello world"
end

post "/newevent" do
	e = Event.new
	e.time = params[:time]
	e.length = params[:length]
	e.place = params[:place]
	e.name = params[:name]
	e.latitude = params[:latitude]
	e.longitude = params[:longitude]
	e.save
	"saved"
end

get "/events" do
	events = Event.all.to_json
end

post "/newpplevent" do
	tuple = People_Event.new
end

get "/pplevents" do
	pplevents = People_Event.all.to_json
end

post "/newteam" do
	Team.create(name: params[:name])
	"new team saved"
end

get "/teams" do
	teams = Team.all.to_json
end

post "/newperson" do
	Person.create(name: params[:name], team_id: params[:team])
	"new person saved"
end

get "/people" do
	people = Person.all.to_json
end

