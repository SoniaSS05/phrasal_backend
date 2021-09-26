class CreateSuccessverbs < ActiveRecord::Migration[6.1]
  def change
    create_table :successverbs do |t|
      t.decimal :rate
      t.references :user, null: false, foreign_key: true
      t.references :verb, null: false, foreign_key: true

      t.timestamps
    end
  end
end
