class CreateTrips < ActiveRecord::Migration
  def change
    create_table :trips do |t|
      t.datetime :time

      t.timestamps
    end
  end
end
