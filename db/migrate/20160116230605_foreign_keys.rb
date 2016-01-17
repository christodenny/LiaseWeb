class ForeignKeys < ActiveRecord::Migration
  def change
	add_foreign_key :people, :teams, column: :id, name: :team_id
	add_foreign_key :contacts, :teams, column: :id, name: :team_id
	add_foreign_key :contacts, :people, column: :id, name: :ppl_id
	add_foreign_key :people_events, :people, column: :id, name: :ppl_id
  	add_foreign_key :people_events, :events, column: :id, name: :event_id
  end
end
