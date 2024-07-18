class CreateAlbumsReaction < ActiveRecord::Migration[7.1]
  def change
    create_table :albums_reactions do |t|
      t.belongs_to :user, null: false, foreign_key: true
      t.belongs_to :album, null: false, foreign_key: true

      t.timestamps
    end
  end
end
