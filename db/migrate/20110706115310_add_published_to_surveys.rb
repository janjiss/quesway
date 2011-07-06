class AddPublishedToSurveys < ActiveRecord::Migration
  def self.up
    add_column :surveys, :published, :boolean, :default => false
  end

  def self.down
    remove_column :surveys, :published
  end
end
