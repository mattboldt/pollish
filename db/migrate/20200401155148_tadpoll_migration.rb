class TadpollMigration < ActiveRecord::Migration[6.0]
  def self.up
    create_table :polls do |t|
      t.belongs_to :room, index: true
      t.string :name

      t.timestamps
    end

    create_table :options do |t|
      t.belongs_to :poll, index: true
      t.string :name

      t.timestamps
    end

    create_table :votes do |t|
      t.belongs_to :user, index: true
      t.belongs_to :option, index: true

      t.timestamps
    end
  end

  def self.down
    drop_table :polls
    drop_table :options
    drop_table :votes
  end
end
