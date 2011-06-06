class CreatePeople < ActiveRecord::Migration

  def change
    create_table :people do |t|
      t.string :name
      t.string :first_name
      t.string :last_name
      t.string :email
      t.string :salt
      t.string :hashed_password
      t.boolean :receive_notifications
      t.timestamps
    end
  end


end
