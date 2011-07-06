class CreateQuestions < ActiveRecord::Migration
  def self.up
    create_table :questions do |t|
      t.integer :survey_id
      t.string :body
      t.string :category
      t.integer :sequence
      t.string :choices
      t.timestamps
    end
  end

  def self.down
    drop_table :questions
  end
end
