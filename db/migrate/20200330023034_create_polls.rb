class CreatePolls < ActiveRecord::Migration[6.0]
  def change
    create_table :polls do |t|
      t.belongs_to :room, index: true
      t.timestamps
    end
  end
end
