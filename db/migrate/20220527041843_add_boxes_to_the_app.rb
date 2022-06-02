class AddBoxesToTheApp < ActiveRecord::Migration[7.0]
  def change
    create_table :boxes do |t|
      t.string :name
      t.string :color
      t.references :user

      t.timestamps
    end

    add_column :documents, :box_id, :integer
  end  
end
