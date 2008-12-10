ActiveRecord::Schema.define(:version => 0) do
  create_table :emails, :force => true do |t|
    t.column :address, :string
    t.column :system_id, :integer
    t.column :md5, :string, :length => 32
  end

  create_table :orders, :force => true do |t|
    t.column :email_id, :integer
  end
end
