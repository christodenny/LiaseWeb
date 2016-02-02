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

get "/events" do
	Event.all.to_json
end

get "/events/:id" do
	e = Event.find(params[:id])
	return status 404 if e.nil?
	e.to_json
end

post "/events" do
	e = Event.new
	e.start_time = params[:start_time]
	e.end_time = params[:end_time]
	e.place = params[:place]
	e.name = params[:name]
	e.latitude = params[:latitude]
	e.longitude = params[:longitude]
	e.description = params[:description]
	e.save
	status 201
	e.to_json
end

put "/events/:id" do
	e = Event.find(params[:id])
	return status 404 if e.nil?
=begin
	e.start_time = params.has_key?(:start_time) ? params[:start_time] : e.start_time
	e.end_time = params.has_key?(:end_time) ? params[:end_time] : e.end_time
	e.place = params.has_key?(:place) ? params[:place] : e.place
	e.name = params.has_key?(:name) ? params[:name] : e.name
	e.latitude = params.has_key?(:latitude) ? params[:latitude] : e.latitude
	e.longitude = params.has_key?(:longitude) ? params[:longitude] : e.longitude
	e.description = params.has_key?(:description) ? params[:description] : e.description
	e.save
=end
	params.each do |key, val|
		if e.has_attribute?('#{key}')
			e.update('#{key}': '#{val}')
	status 202
end

delete "/events/:id" do
	e = Event.find(params[:id])
	return status 404 if e.nil?
	e.destroy
	status 202
end

get "/peopleevents" do
	People_Event.all.to_json
end

get "/peopleevents/:id" do
	pple = People_Event.find(params[:id])
	return status 404 if pple.nil?
	pple.to_json
end

post "/peopleevents" do
	People_Event.create(ppl_id: params[:ppl_id], event_id: params[:event_id])
	status 201
	People_Event.last[:id].to_json
end

delete "/peopleevents/:id" do
	pple = People_Event.find(params[:id])
	return status 404 if pple.nil?
	pple.destroy
	status 202
end

get "/teams" do
	Team.all.to_json
end

get "/teams/:id" do
	team = Team.find(params[:id])
	return status 404 if team.nil?
	team.to_json
end

post "/teams" do
	Team.create(name: params[:name])
	status 201
end

get "/teams/:id/people" do
	Person.where(team_id: params[:id]).to_json
end

get "/teams/:id/contacts" do
	Contact.where(team_id: params[:id]).to_json
end

put "/teams/:id" do
	team = Team.find(params[:id])
	return status 404 if team.nil?
	team.name = params[:name]
	team.save
	status 202
end

delete "/teams/:id" do
	team = Team.find(params[:id])
	return status 404 if team.nil?
	team.destroy
	status 202
end

get "/people" do
	Person.all.to_json
end

get "/people/:id" do
	person = Person.find(params[:id])
	return status 404 if person.nil?
	person.to_json
end

post "/people" do
	Person.create(name: params[:name], team_id: params[:team_id])
	Person.last[:id].to_s
end

get "/people/:id/events" do
	array = []
	pplevents = People_Event.where(ppl_id: params[:id])
	pplevents.each { |pplevent| array += Event.where(id: pplevent.event_id)}
	array.to_json
end

put "/people/:id" do
	person = Person.find(params[:id])
	return status 404 if person.nil?
	person.name = params[:name]
	person.team_id = params[:team_id]
	person.token = params[:token]
	person.save
	status 202
end

delete "/people/:id" do
	person = Person.find(params[:id])
	return status 404 if person.nil?
	person.destroy
	status 202
end

get "/contacts" do
	Contact.all.to_json
end

get "/contacts/:id" do
	contact = Contact.find(params[:id])
	return status 404 if contact.nil?
	contact.to_json
end

post "/contacts" do
	c = Contact.new
	c.team_id = params[:team_id]
	c.ppl_id = params[:ppl_id]
	c.phone_number = params[:phone_number]
	c.ppl_type = params[:ppl_type]
	c.save
	status 201
	c[:id].to_s
end

put "/contacts/:id" do
	contact = Contact.find(params[:id])
	return status 404 if contact.nil?
	c.team_id = params[:team_id]
	c.ppl_id = params[:ppl_id]
	c.phone_number = params[:phone_number]
	c.ppl_type = params[:ppl_type]
	c.save
	status 202
end

delete "/contacts/:id" do
	contact = Contact.find(params[:id])
	return status 404 if contact.nil?
	contact.destroy
	status 202
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
		temp.push(coaches.team_id + ":" + coaches.ppl_id)
		@teamcontacts.push(temp)
	end
	erb :teamsContacts
end

get "/message" do
	erb :message
end

get "/addevent" do
	@events = Event.all.order(:start_time)
	erb :events
end

post "/addevent" do
	new_event = Event.new
	new_event.name = params[:name]
	new_event.start_time = params[:start_time]
	new_event.end_time = params[:end_time]
	new_event.place = params[:place]
	new_event.latitude = params[:latitude]
	new_event.longitude = params[:longitude]
	new_event.description = params[:description]
	new_event.save
	"Name was '#{params[:name]}'"
end

