class CreatePetitions < ActiveRecord::Migration

  def change
    create_table :petitions do |t|
      t.string :name
      t.string :subheading
      t.string :title
      t.string :subtitle
      t.text :intro
      t.text :body
      t.text :commitment
      t.text :contact
      t.string   :logo_file_name
      t.string   :logo_content_type
      t.integer  :logo_file_size
      t.datetime :logo_updated_at
      t.string :sender
      t.boolean :published
      t.boolean :active
      t.datetime :started_at
      t.datetime :stopped_at
      t.integer :creator_id, :references=>:people
      t.integer :updater_id, :references=>:people
      t.timestamps
    end
  end

end
