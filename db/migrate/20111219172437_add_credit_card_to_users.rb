class AddCreditCardToUsers < ActiveRecord::Migration
  def change
    add_column :users, :credit_card, :string
    add_column :users, :stripe_customer_token, :string
  end
end
