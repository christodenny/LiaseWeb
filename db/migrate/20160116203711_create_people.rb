class CreatePeople <ActiveRecord::Migration
  def change
  	create_table :people do |t|
		t.string :name
		t.integer :team_id
		t.string :token
	end
  end
end
