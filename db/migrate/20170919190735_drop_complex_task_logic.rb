class DropComplexTaskLogic < ActiveRecord::Migration[5.1]
  def change
    remove_foreign_key :taskexecutionrequirement, name: "fk_taskexecutionrequirement_stockitem"
    remove_foreign_key :taskexecutionrequirement, name: "fk_taskexecutionrequirement_taskexecutionitem"
    remove_foreign_key :taskexecutionrequirement, name: "fk_taskexecutionrequirement_taskcardrequirementitem"
    remove_foreign_key :taskcardrequirement, name: "fk_taskcardrequirement_taskcardrequirement_taskcard"
    remove_foreign_key :taskcardrequirementitem, name: "fk_taskcardrequirement_requirementitem_productsubtype"
    remove_foreign_key :taskcardrequirementitem, name: "fk_taskcardrequirementitem_requirementitem_requirement"

    drop_table :taskexecutionrequirement
    drop_table :taskcardrequirement
    drop_table :taskcardrequirementitem
  end
end
