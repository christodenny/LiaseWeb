class CreateEvents < ActiveRecord::Migration
  def change
  	create_table :events do |t|
		t.timestamp :start_time
		t.timestamp :end_time
		t.string :place
		t.string :name
		t.decimal :latitude, :precision => 9, :scale => 6
		t.decimal :longitude, :precision => 9, :scale => 6
		t.text :description
	end
  end
end
