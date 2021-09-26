class CreateMeanings < ActiveRecord::Migration[6.1]
  def change
    create_table :meanings do |t|
      t.string :definition
      t.references :phrasal, null: false, foreign_key: true

      t.timestamps
    end
  end
end
