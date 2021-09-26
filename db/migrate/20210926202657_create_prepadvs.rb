class CreatePrepadvs < ActiveRecord::Migration[6.1]
  def change
    create_table :prepadvs do |t|
      t.string :name

      t.timestamps
    end
  end
end
