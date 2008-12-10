ActiveRecord::Schema.define(:version => 0) do
  create_table :chickens, :force => true do |t|
    t.column :name, :string
    t.column :age, :integer
    t.column :md5, :string, :length => 32
  end
end
