class CreateEmployeeAttaindances < ActiveRecord::Migration
  def change
    create_table :employee_attaindances do |t|
      t.references :employee, index: true, foreign_key: true
      t.date :check_in_date
      t.integer :check_in_hour
      t.integer :check_in_minute
      t.boolean :is_late

      t.timestamps null: false
    end
  end
end
