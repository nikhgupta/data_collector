class CreateAggregates < ActiveRecord::Migration
  def change
    create_table :aggregates do |t|
      t.references :sensor, index: true, foreign_key: true
      t.time :period_start
      t.time :period_end
      t.string :period_length
      t.string :total
      t.string :count
      t.string :mean
      t.string :std_dev

      t.timestamps null: false
    end
  end
end
