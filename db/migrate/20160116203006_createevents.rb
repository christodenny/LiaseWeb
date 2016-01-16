class CreateEvents < ActiveRecord::Migration
  def change
  	create_table :events do |t|
		t.timestamp :time
		t.integer :length
		t.string :place
		t.string :name
		t.decimal{9, 6} :longitude
		t.decimal{9, 6} :latitude
	end
  end
end
