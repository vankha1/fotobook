class AddPhotosCountToUser < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :photos_count, :integer
  end
end
