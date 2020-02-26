class Vendor
  attr_reader :name, :inventory

  def initialize(name_param)
    @name = name_param
    @inventory = {}
  end
end
