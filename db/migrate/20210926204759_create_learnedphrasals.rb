class CreateLearnedphrasals < ActiveRecord::Migration[6.1]
  def change
    create_table :learnedphrasals do |t|
      t.references :phrasal, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
