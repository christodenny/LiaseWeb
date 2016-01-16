class CreateEvents < ActiveRecord::Migration
  def change
  	create_table :events do |t|
		t.timestamp :time
		t.integer :length
		t.string :place
		t.string :name
		t.decimal :latitude, :precision => 9, :scale => 6
		t.decimal :longitude, :precision => 9, :scale => 6
	end
  end
end
