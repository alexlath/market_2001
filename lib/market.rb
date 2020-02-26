class Market
  attr_reader :name, :vendors

  def initialize(name_param)
    @name = name_param
    @vendors = []
  end

  def add_vendor(vendor_param)
    @vendors << vendor_param
  end
end
