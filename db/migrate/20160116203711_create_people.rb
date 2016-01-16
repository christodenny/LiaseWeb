class CreatePeople <ActiveRecord::Migration
  def change
  	create_table :people do |t|
		t.string :name
		#t.integer :team_id
	end
  end
end
