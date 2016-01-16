class ForeignKeys < ActiveRecord::Migration
  def change
	add_foreign_key :people, :teams, column: :id, name: :fk_people_teams
	add_foreign_key :contacts, :teams, column: :id, name: :fk_contacts_teams
	add_foreign_key :contacts, :people, column: :id, name: :fk_contacts_people
	add_foreign_key :people_events, :people, column: :id, name: :fk_people_events_people
  	add_foreign_key :people_events, :events, column: :id, name: :fk_people_events_events
  end
end
