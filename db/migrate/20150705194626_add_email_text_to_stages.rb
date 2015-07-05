class AddEmailTextToStages < ActiveRecord::Migration
  def change
    add_column :stages, :email_text, :text
  end
end
