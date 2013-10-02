class CreateUsermeta < ActiveRecord::Migration
  def change
    create_table :usermeta do |t|
      t.references :user, index: true
      t.string :key
      t.text :value
      t.bool :option

      t.timestamps
    end
  end
end
