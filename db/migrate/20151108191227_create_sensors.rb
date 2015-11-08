class CreateSensors < ActiveRecord::Migration
  def change
    create_table :sensors do |t|
      t.references :user, index: true, foreign_key: true
      t.string :uuid
      t.string :format
      t.string :length

      t.timestamps null: false
    end
  end
end
