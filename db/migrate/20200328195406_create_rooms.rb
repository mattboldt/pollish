class CreateRooms < ActiveRecord::Migration[6.0]
  def change
    create_table :rooms do |t|
      t.belongs_to :user, index: true
      t.string :name

      t.timestamps
    end
  end
end
