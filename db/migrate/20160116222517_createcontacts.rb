class Createcontacts < ActiveRecord::Migration
  def change
  	create_table :contacts do |t|
		t.integer :team_id
		t.integer :ppl_id
		t.string :phone_number
		t.boolean :ppl_type
	end
  end
end
