class CreatePhrasals < ActiveRecord::Migration[6.1]
  def change
    create_table :phrasals do |t|
      t.references :verb, null: false, foreign_key: true
      t.references :prepadv, null: false, foreign_key: true

      t.timestamps
    end
  end
end
