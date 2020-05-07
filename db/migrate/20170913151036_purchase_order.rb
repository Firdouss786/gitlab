class PurchaseOrder < ActiveRecord::Migration[5.1]
  def change
    remove_foreign_key :purchase_order, name: "fk_purchase_order_po_creator_01"
    remove_foreign_key :purchase_order_user, name: "fk_purchase_order_user_purchase_order_01"
    remove_foreign_key :purchase_order_user, name: "fk_purchase_order_user_user_02"

    drop_table :purchase_order
    drop_table :purchase_order_user
  end
end