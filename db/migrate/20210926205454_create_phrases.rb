class CreatePhrases < ActiveRecord::Migration[6.1]
  def change
    create_table :phrases do |t|
      t.string :question
      t.string :answer
      t.references :verb, null: false, foreign_key: true

      t.timestamps
    end
  end
end
