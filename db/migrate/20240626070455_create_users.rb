class CreateUsers < ActiveRecord::Migration[7.1]
  def change
    create_table :users do |t|
      t.string :user_name
      t.string :first_name
      t.string :last_name
      t.string :email
      t.string :password
      t.boolean :is_admin
      t.string :avatar

      t.timestamps
    end
  end
end
