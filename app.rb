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

require_relative 'api'

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
get "/event/:id" do
	params[:id].to_s
end

