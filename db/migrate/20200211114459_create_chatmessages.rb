class CreateChatmessages < ActiveRecord::Migration[6.0]
  def change
    create_table :chatmessages do |t|
      t.references :user, index: true, foreign_key: true
      t.references :reciever, index: true
      t.string :message

      t.timestamps
    end
    add_foreign_key :chatmessages, :users, column: :reciever_id
  end
end
