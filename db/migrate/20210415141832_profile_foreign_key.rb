class ProfileForeignKey < ActiveRecord::Migration[6.1]
  def change
    add_foreign_key :profiles, :users
  end
end
