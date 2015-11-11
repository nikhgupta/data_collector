class CreateAggregates < ActiveRecord::Migration
  def change
    create_table :aggregates do |t|
      t.references :sensor, index: true, foreign_key: true

      t.datetime :period_start
      t.datetime :period_end
      t.string :period_length

      t.decimal :total,   scale: 3, precision: 10
      t.decimal :count,   scale: 3, precision: 10
      t.decimal :mean,    scale: 3, precision: 10
      t.decimal :std_dev, scale: 3, precision: 10

      t.timestamps null: false
    end
  end
end
