class CreatePetitions < ActiveRecord::Migration

  def change
    create_table :petitions do |t|
      t.string :name
      t.string :title
      t.string :subtitle
      t.text :intro
      t.text :body
      t.string :sender
      t.boolean :published
      t.boolean :active
      t.timestamp :started_at
      t.timestamp :stopped_at
      t.integer :creator_id, :references=>:people
      t.integer :updater_id, :references=>:people
      t.timestamps
    end
  end

end
