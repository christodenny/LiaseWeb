class ForeignKeys < ActiveRecord::Migration
  def change
	add_foreign_key :people, :teams, primary_key: "id"
	add_foreign_key :contacts, :teams, primary_key: "id"
	add_foreign_key :contacts, :people, primary_key: "id"
	add_foreign_key :people_events, :people, primary_key: "id"
  	add_foreign_key :people_events, :events, primary_key: "id"
  end
end
