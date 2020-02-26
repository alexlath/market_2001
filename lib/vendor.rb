class Vendor
  attr_reader :name, :inventory

  def initialize(name_param)
    @name = name_param
    @inventory = Hash.new(0)
  end

  def check_stock(item_param)
    @inventory[item_param]
  end
end
