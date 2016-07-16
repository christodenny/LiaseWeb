get "/" do
	"hello world"
end
get "/api/events" do
	Event.all.to_json
end
get "/api/events/:id" do
	e = Event.find(params[:id])
	e.to_json
end
get "/api/events/:id/people" do
	"TODO"
end
post "/api/events" do
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
	e[:id].to_s
end
put "/api/events/:id" do
	e = Event.find(params[:id])
	params.each do |key, val|
		if e.has_attribute?(key)
			e.update(key=>"#{val}")
		end
	end
	status 202
end
delete "/api/events/:id" do
	e = Event.find(params[:id])
	e.destroy
	status 202
end
get "/api/peopleevents" do
	People_Event.all.to_json
end
get "/api/peopleevents/:id" do
	pple = People_Event.find(params[:id])
	pple.to_json
end
post "/api/peopleevents" do
	pple = People_Event.new
	pple.ppl_id = params[:ppl_id]
	pple.event_id = params[:event_id]
	pple.save
	status 201
	pple[:id].to_s
end
delete "/api/peopleevents/:id" do
	pple = People_Event.find(params[:id])
	pple.destroy
	status 202
end
get "/api/teams" do
	Team.all.to_json
end
get "/api/teams/:id" do
	team = Team.find(params[:id])
	team.to_json
end
post "/api/teams" do
	team = Team.new
	team.name = params[:name]
	team.save
	status 201
	team[:id].to_s
end
get "/api/teams/:id/people" do
	Person.where(team_id: params[:id]).to_json
end
get "/api/teams/:id/contacts" do
	Contact.where(team_id: params[:id]).to_json
end
put "/api/teams/:id" do
	team = Team.find(params[:id])
	params.each do |key, val|
		if team.has_attribute?(key)
			team.update(key=>"#{val}")
		end
	end

	status 202
end
delete "/api/teams/:id" do
	team = Team.find(params[:id])
	team.destroy
	status 202
end
get "/api/people" do
	Person.all.to_json
end
get "/api/people/:id" do
	person = Person.find(params[:id])
	person.to_json
end
get "/api/people/:id/events" do
	"TODO"
end
post "/api/people" do
	p = Person.new
	p.name = params[:name]
	p.team_id = params[:team_id]
	p.save
	p[:id].to_s
end
get "/api/people/:id/events" do
	array = []
	pplevents = People_Event.where(ppl_id: params[:id])
	pplevents.each { |pplevent| array += Event.where(id: pplevent.event_id)}
	array.to_json
end
put "/api/people/:id" do
	person = Person.find(params[:id])
	params.each do |key, val|
		if person.has_attribute?(key)
			person.update(key=>"#{val}")
		end
	end
	status 202
end
delete "/api/people/:id" do
	person = Person.find(params[:id])
	person.destroy
	status 202
end
get "/api/contacts" do
	Contact.all.to_json
end
get "/api/contacts/:id" do
	contact = Contact.find(params[:id])
	contact.to_json
end
post "/api/contacts" do
	c = Contact.new
	c.team_id = params[:team_id]
	c.ppl_id = params[:ppl_id]
	c.phone_number = params[:phone_number]
	c.ppl_type = params[:ppl_type]
	c.save
	status 201
	c[:id].to_s
end
put "/api/contacts/:id" do
	contact = Contact.find(params[:id])
	params.each do |key, val|
		if contact.has_attribute?(key)
			contact.update(key=>"#{val}")
		end
	end
	status 202
end
delete "/api/contacts/:id" do
	contact = Contact.find(params[:id])
	contact.destroy
	status 202
end

