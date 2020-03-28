class CreateVoters < ActiveRecord::Migration[6.0]
  def change
    create_table :voters do |t|
      t.string :name

      t.timestamps
    end
  end
end
