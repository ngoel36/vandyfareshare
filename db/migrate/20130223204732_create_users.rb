class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name

      t.timestamps
    end

    create_table :trips_users, :id => false do |t|
      t.references :trip, :user
    end

    add_index :trips_users, [:trip_id, :user_id]    
  end
end
