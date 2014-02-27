class CreateResultlogs < ActiveRecord::Migration
  def change
    create_table :resultlogs do |t|
    	t.string  :event 
    	t.boolean :status
    	t.integer :tickets
      t.timestamps
    end
  end
end
