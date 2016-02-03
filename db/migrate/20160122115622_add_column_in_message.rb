class AddColumnInMessage < ActiveRecord::Migration
  def change
    add_column :messages, :sent_message, :text
    rename_column :messages, :message, :recieved_message
  end
end
