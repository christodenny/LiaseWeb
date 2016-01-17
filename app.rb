require 'sinatra'
require 'sinatra/activerecord'

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

get "/newevent" do
	e = Event.new
	e.time = params['time']
	e.length = params['length']
	e.place = params['place']
	e.name = params['name']
	e.latitude = params['latitude']
	e.longitude = params['longitude']
	e.save
	"saved"
end

