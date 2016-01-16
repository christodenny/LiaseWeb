class ForeignKeys < ActiveRecord::Migration
  def change
	add_foreign_key :people, :teams, column: :id
	add_foreign_key :contacts, :teams, column: :id
	add_foreign_key :contacts, :people, column: :id
	add_foreign_key :people_events, :people, column: :id
  	add_foreign_key :people_events, :events, column: :id
  end
end
