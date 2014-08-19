class CreateStudents < ActiveRecord::Migration
  def change
    create_table :students do |t|
    	t.string :std_name
    	t.integer :age
    	t.string :gender
    	t.string :standard
    	t.string :father_name
    	t.string :mother_name
    	t.string :address    	 
    	t.timestamps
    end
  end
end
