class CreateCategories < ActiveRecord::Migration[5.2]
  def change
    create_table :categories do |t|
      t.string :tag_name

      t.timestamps
    end
    add_index :categories, :tag_name, unique:true
  end
end
