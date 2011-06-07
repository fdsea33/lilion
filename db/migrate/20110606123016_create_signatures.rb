class CreateSignatures < ActiveRecord::Migration
  def change
    create_table :signatures do |t|
      t.integer :petition_id, :references=>:petitions
      t.string :number
      t.string :nature
      t.string :first_name
      t.string :last_name
      t.string :email
      t.string :language
      t.text :infos
      t.string :ip_address
      t.string :hashed_key
      t.string :checked_at
      t.boolean :locked
      t.timestamps
    end
  end
end
