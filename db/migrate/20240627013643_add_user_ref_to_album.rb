class AddUserRefToAlbum < ActiveRecord::Migration[7.1]
  def change
    add_reference :albums, :user, null: false, foreign_key: true
  end
end
