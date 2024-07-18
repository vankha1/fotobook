class CreatePhotosReaction < ActiveRecord::Migration[7.1]
  def change
    create_table :photos_reactions do |t|
      t.belongs_to :user, null: false, foreign_key: true
      t.belongs_to :photo, null: false, foreign_key: true

      t.timestamps
    end
  end
end
