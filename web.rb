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
	erb :addevent
end

get "/updateevent/:id" do
	@event = Event.find(params[:id])
	erb :updateevent
end

get "/events" do
	@events = Event.all.order(:start_time)
	erb :events
end
