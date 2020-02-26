class Market
  attr_reader :name, :vendors

  def initialize(name_param)
    @name = name_param
    @vendors = []
  end

  def add_vendor(vendor_param)
    @vendors << vendor_param
  end

  def vendor_names
    @vendors.map { |vendor| vendor.name }
  end

  def vendors_that_sell(item_param)
    @vendors.select do |vendor|
      vendor.check_stock(item_param) > 0
    end
  end

  def list_items
    inventories = @vendors.map { |vendor| vendor.inventory }
    items = inventories.flat_map { |inventory| inventory.keys }
    items.uniq
  end

  def total_quantity(item_param)
    @vendors.sum do |vendor|
      vendor.check_stock(item_param)
    end
  end

  def total_inventory
    total_inventory = Hash.new
    list_items.each do |item|
      total_inventory[item] = {
        quantity: total_quantity(item),
        vendors: vendors_that_sell(item)
      }
    end
    total_inventory
  end

  def overstocked_items
    list_items.select do |item|
      vendors_that_sell(item).length > 1 &&
      total_quantity(item) > 50
    end
  end

  def sorted_item_list
    item_names = list_items.map { |item| item.name }
    item_names.sort
  end
end
