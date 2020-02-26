class Market
  attr_reader :name, :vendors

  def initialize(name_param)
    @name = name_param
    @vendors = []
  end
end
