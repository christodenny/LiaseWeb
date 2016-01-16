class Createpplevents < ActiveRecord::Migration
  def change
  	create_table :people_events do |t|
		t.integer :ppl_id
		t.integer :event_id
	end
  end
end
