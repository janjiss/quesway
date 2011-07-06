class CreateTrackers < ActiveRecord::Migration
  def self.up
    create_table :trackers do |t|
      t.integer :survey_id
      t.integer :respondent_id
      t.integer :progress, :default => 1
      t.boolean :completed, :default => false
      t.timestamps
    end
  end

  def self.down
    drop_table :trackers
  end
end
