class AddEmailUniquenessIndex < ActiveRecord::Migration
  def self.up
    add_index :customers, :email, :unique => true
  end

  def self.down
    remove_index :customers, :email
  end
end
