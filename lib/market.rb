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

  def total_quantity(item_param)
    @vendors.sum do |vendor|
      vendor.check_stock(item_param)
    end
  end

  # def total_inventory
  # end
end
