class ForeignKeys < ActiveRecord::Migration
  def change
	add_foreign_key :people, :teams, column: 'team_id', name: :fk_people_teams
	add_foreign_key :contacts, :teams, column: :team_id, name: :fk_contacts_teams
	add_foreign_key :contacts, :people, column: :ppl_id, name: :fk_contacts_people
	add_foreign_key :people_events, :people, column: :ppl_id, name: :fk_ppl_events_people
  	add_foreign_key :people_events, :events, column: :event_id, name: :fk_ppl_events_events
  end
end
