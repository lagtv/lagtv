class AddOrdinalToCategory < ActiveRecord::Migration
  def change
    add_column :forem_categories, :ordinal, :integer

    Forem::Category.find_by_name("LAG TV").try(:update_attributes, {:ordinal => 1})
    Forem::Category.find_by_name("Off-Topic").try(:update_attributes, {:ordinal => 2})
    Forem::Category.find_by_name("E-Sports").try(:update_attributes, {:ordinal => 3})
    Forem::Category.find_by_name("Gaming").try(:update_attributes, {:ordinal => 4})
    Forem::Category.find_by_name("Platforms").try(:update_attributes, {:ordinal => 5})
    Forem::Category.find_by_name("Tech").try(:update_attributes, {:ordinal => 6})
    Forem::Category.find_by_name("Art").try(:update_attributes, {:ordinal => 7})
    Forem::Category.find_by_name("Support").try(:update_attributes, {:ordinal => 8})
  end
end
