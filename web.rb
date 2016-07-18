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
	erb :addevent
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
	#{}"Name was '#{params[:name]}'"
	@events = Event.all.order(:start_time)
	erb :addevent
end
get "/events" do
	@events = Event.all.order(:start_time)
	erb :events
end
