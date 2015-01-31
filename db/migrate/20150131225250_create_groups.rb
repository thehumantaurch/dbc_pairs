class CreateGroups < ActiveRecord::Migration
  def change
    create_table :groups do |t|
      t.references :cohort
      t.text :assignment

      t.timestamps null: false
    end
  end
end
