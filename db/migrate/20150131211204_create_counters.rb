class CreateCounters < ActiveRecord::Migration
  def change
    create_table :counters do |t|
      t.references :pair
      t.integer :count, default: 0

      t.timestamps null: false
    end
  end
end
