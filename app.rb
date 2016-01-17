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
	ret = e[:id].to_s
end

get "/events" do
	Event.all.to_json
end

get "/eventbyid" do
	Event.find_by(id: params[:id])
end

get "/eventsbypersonid" do
	array = []
	pplevents = People_Event.where(ppl_id: params[:id])
	pplevents.each { |pplevent| array += Event.where(id: pplevent.event_id)}
	array.to_json
end

post "/newpplevent" do
	People_Event.create(ppl_id: params[:ppl_id], event_id: params[:event_id])
	People_Event.last[:id].to_s
end

get "/pplevents" do
	People_Event.all.to_json
end

get "ppleventbyid" do
	People_Event.find_by(id: params[:id])
end

post "/newteam" do
	Team.create(name: params[:name])[:id].to_s
end

get "/teams" do
	Team.all.to_json
end

get "/teambyid" do
	Team.find_by(id: params[:id])
end

post "/newperson" do
	Person.create(name: params[:name], team_id: params[:team_id])
	Person.last[:id].to_s
end

get "/people" do
	Person.all.to_json
end

get "/personbyid" do
	Person.find_by(id: params[:id])
end

get "/peoplebyteamid" do
	Person.where(team_id: params[:id]).to_json
end

post "/newcontact" do
	c = Contact.new
	c.team_id = params[:team_id]
	c.ppl_id = params[:ppl_id]
	c.phone_number = params[:phone_number]
	c.ppl_type = params[:ppl_type]
	c.save
	c[:id].to_s
end

get "/contacts" do
	Contact.all.to_json
end

get "/contactbyid" do
	Contact.find_by(id: params[:id])
end

get "/contactsbyteamid" do
	Contact.where(team_id: params[:id]).to_json
end

get "/schedule" do
	@events = Event.all.order(:start_time)
	erb :schedule
end

get "/teamscontacts" do
	coaches = Contact.where(ppl_type: true)
	@teamcontacts = []
	coaches.each do |coach| 
	    temp = []
		temp.push(coach.phone_number)
		temp.push(Person.find_by(id: coach.ppl_id).name)
		temp.push(Team.find_by(id: coach.team_id).name)
		temp.push(coach.team_id + ":" + coach.ppl_id)
		@teamcontacts.push(temp)
	end
	erb :teamsContacts
end

get "/message" do
	erb :message
end



