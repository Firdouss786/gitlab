class UpdateOpenToActive < ActiveRecord::Migration[6.0]
  def self.up
    execute "UPDATE activities SET state = 'ACTIVE' WHERE state = 'OPEN'"
  end
end
