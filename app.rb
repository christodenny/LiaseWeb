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
	e.start_time = params[:start_time]
	e.end_time = params[:end_time]
	e.place = params[:place]
	e.name = params[:name]
	e.latitude = params[:latitude]
	e.longitude = params[:longitude]
	e.description = params[:description]
	e.save
	ret = e.id
end

get "/events" do
	events = Event.all.to_json
end

get "/eventbyid" do
	event = Event.find_by(id: params[:id])
end

get "/eventsbypersonid" do
	array = []
	pplevents = People_Event.where(ppl_id: params[:id])
	pplevents.each { |pplevent| array += Event.where(id: pplevent.event_id)}
	ret = array.to_json
end

post "/newpplevent" do
	ret = People_Event.create(ppl_id: params[:ppl_id], event_id: params[:event_id]).id
end

get "/pplevents" do
	pplevents = People_Event.all.to_json
end

get "ppleventbyid" do
	pplevent = People_Event.find_by(id: params[:id])
end

post "/newteam" do
	ret = Team.create(name: params[:name]).id
end

get "/teams" do
	teams = Team.all.to_json
end

get "/teambyid" do
	team = Team.find_by(id: params[:id])
end

post "/newperson" do
	Person.create(name: params[:name], team_id: params[:team])
	ret = Person.last.name
end

get "/people" do
	people = Person.all.to_json
end

get "/personbyid" do
	person = Person.find_by(id: params[:id])
end

get "/peoplebyteamid" do
	people = Person.where(team_id: params[:id]).to_json
end

post "/newcontact" do
	c = Contact.new
	c.team_id = params[:team_id]
	c.ppl_id = params[:ppl_id]
	c.phone_number = params[:phone_number]
	c.ppl_type = params[:ppl_type]
	c.save
	ret = c.id
end

get "/contacts" do
	contacts = Contact.all.to_json
end

get "/contactbyid" do
	contact = Contact.find_by(id: params[:id])
end

get "/contactsbyteamid" do
	contacts = Contact.where(team_id: params[:id]).to_json
end

