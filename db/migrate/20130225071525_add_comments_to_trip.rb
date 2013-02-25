class AddCommentsToTrip < ActiveRecord::Migration
  def change
    add_column :trips, :notes, :string, :default => ""
  end
end
