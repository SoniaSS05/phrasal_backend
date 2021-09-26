class CreateMeanbodies < ActiveRecord::Migration[6.1]
  def change
    create_table :meanbodies do |t|
      t.string :synonyms
      t.string :anthonyms
      t.string :example
      t.references :meaning, null: false, foreign_key: true

      t.timestamps
    end
  end
end
