class CreateRespondents < ActiveRecord::Migration
  def self.up
    create_table :respondents do |t|
      t.string :name
      t.timestamps
    end
  end

  def self.down
    drop_table :respondents
  end
end
