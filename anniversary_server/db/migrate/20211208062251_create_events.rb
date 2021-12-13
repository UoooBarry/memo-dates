class CreateEvents < ActiveRecord::Migration[6.1]
  def change
    create_table :events do |t|
      t.string :title, null: false
      t.text :description
      t.integer :frequency, null: false
      t.integer :layout, null: false, default: 0
      t.date :happen_date

      t.timestamps
    end
  end
end
