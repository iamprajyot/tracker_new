class CreateEmployees < ActiveRecord::Migration
  def change
    create_table :employees do |t|
      t.string :username
      t.boolean :is_deleted, default: false

      t.timestamps null: false
    end
  end
end
