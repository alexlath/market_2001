require 'minitest/autorun'
require 'minitest/pride'
require './lib/item'
require './lib/vendor'
require './lib/market'

class MarketTest < Minitest::Test
  def setup
    @market = Market.new("South Pearl Street Farmers Market")
    @item1 = Item.new({name: 'Peach', price: "$0.75"})
    @item2 = Item.new({name: 'Tomato', price: '$0.50'})
    @item3 = Item.new({name: "Peach-Raspberry Nice Cream", price: "$5.30"})
    @item4 = Item.new({name: "Banana Nice Cream", price: "$4.25"})
    @item5 = Item.new({name: 'Onion', price: '$0.25'})
    @vendor1 = Vendor.new("Rocky Mountain Fresh")
    @vendor1.stock(@item1, 35)
    @vendor1.stock(@item2, 7)
    @vendor2 = Vendor.new("Ba-Nom-a-Nom")
    @vendor2.stock(@item3, 25)
    @vendor2.stock(@item4, 50)
    @vendor3 = Vendor.new("Palisade Peach Shack")
    @vendor3.stock(@item1, 65)
  end

  def test_it_can_exist
    assert_instance_of Market, @market
  end

  def test_it_has_attributes
    assert_equal "South Pearl Street Farmers Market", @market.name
    assert_equal [], @market.vendors
    # assert_equal "24/02/2020", @market.date
  end

  def test_it_can_add_vendors
    @market.add_vendor(@vendor1)
    @market.add_vendor(@vendor2)
    @market.add_vendor(@vendor3)

    assert_equal [@vendor1, @vendor2, @vendor3], @market.vendors
  end

  def test_it_can_name_vendors
    @market.add_vendor(@vendor1)
    @market.add_vendor(@vendor2)
    @market.add_vendor(@vendor3)

    expected = ["Rocky Mountain Fresh", "Ba-Nom-a-Nom", "Palisade Peach Shack"]

    assert_equal expected, @market.vendor_names
  end

  def test_it_can_find_vendors_that_sell_item
    @market.add_vendor(@vendor1)
    @market.add_vendor(@vendor2)
    @market.add_vendor(@vendor3)

    assert_equal [@vendor1, @vendor3], @market.vendors_that_sell(@item1)
    assert_equal [@vendor2], @market.vendors_that_sell(@item4)
  end

  def test_it_can_list_items_in_market
    @market.add_vendor(@vendor1)
    @market.add_vendor(@vendor2)
    @market.add_vendor(@vendor3)

    assert_equal [@item1, @item2, @item3, @item4], @market.list_items
  end

  def test_it_can_total_quantity_of_item
    @market.add_vendor(@vendor1)
    @market.add_vendor(@vendor2)
    @market.add_vendor(@vendor3)

    assert_equal 100, @market.total_quantity(@item1)
    assert_equal 7, @market.total_quantity(@item2)
  end

  def test_it_can_summarize_total_inventory
    @market.add_vendor(@vendor1)
    @market.add_vendor(@vendor2)
    @market.add_vendor(@vendor3)
    @vendor3.stock(@item3, 10)

    expected = {
      @item1 => {
        quantity: 100,
        vendors: [@vendor1, @vendor3]
      },
      @item2 => {
        quantity: 7,
        vendors: [@vendor1]
      },
      @item3 => {
        quantity: 35,
        vendors: [@vendor2, @vendor3]
      },
      @item4 => {
        quantity: 50,
        vendors: [@vendor2]
      }
    }

    assert_equal expected, @market.total_inventory
  end

  def test_it_can_list_overstocked_items
    @market.add_vendor(@vendor1)
    @market.add_vendor(@vendor2)
    @market.add_vendor(@vendor3)
    @vendor3.stock(@item3, 10)

    assert_equal [@item1], @market.overstocked_items
  end

  def test_it_can_sort_market_list
    @market.add_vendor(@vendor1)
    @market.add_vendor(@vendor2)
    @market.add_vendor(@vendor3)
    @vendor3.stock(@item3, 10)

    expected = ["Banana Nice Cream", "Peach", "Peach-Raspberry Nice Cream", "Tomato"]

    assert_equal expected, @market.sorted_item_list
  end
end
