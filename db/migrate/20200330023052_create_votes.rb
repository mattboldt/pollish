class CreateVotes < ActiveRecord::Migration[6.0]
  def change
    create_table :votes do |t|
      t.belongs_to :poll, index: true
      t.belongs_to :voter, index: true
      t.integer :value

      t.timestamps
    end
  end
end
