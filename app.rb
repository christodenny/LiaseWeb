require 'sinatra'
require 'sinatra/activerecord'
require 'json'

db = URI.parse('postgres://oaafdlhwmkznte:mP2aHxLDrp7Xz_5Hy7KQo_hpBC@ec2-54-225-165-132.compute-1.amazonaws.com:5432/d58tgju84l2ipv')
#db = URI.parse('postgres://testuser:password@localhost:5432/LiaseTestDB')

ActiveRecord::Base.establish_connection(
	:adapter => 'postgresql',
	:host => db.host,
	:username => db.user,
	:password => db.password,
	:database => db.path[1..-1],
	:encoding => 'utf8'
)

# represents an event
class Event < ActiveRecord::Base
	self.table_name = "events"
end
# represents a mapping between a person and an event
class People_Event < ActiveRecord::Base
	self.table_name = "people_events"
end
# represents a person
class Person < ActiveRecord::Base
	self.table_name = "people"
end
# represents a team made up of people
class Team < ActiveRecord::Base
	self.table_name = "teams"
end
class Contact < ActiveRecord::Base
	self.table_name = "contacts"
end

require_relative 'api'
require_relative 'web'
