class ForeignKeys < ActiveRecord::Migration
  def change
	add_foreign_key :people, :teams, :primary_key
	add_foreign_key :contacts, :teams
	add_foreign_key :contacts, :people
	add_foreign_key :people_events, :people
  	add_foreign_key :people_events, :events
  end
end
