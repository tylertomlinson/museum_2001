require_relative 'test_helper'
require './lib/exhibit'
require './lib/patron'
require './lib/museum'

class MusemTest < Minitest::Test

  def setup
     @dmns = Museum.new("Denver Museum of Nature and Science")
     @gems_and_minerals = Exhibit.new({name: "Gems and Minerals", cost: 0})
     @dead_sea_scrolls = Exhibit.new({name: "Dead Sea Scrolls", cost: 10})
     @imax = Exhibit.new({name: "IMAX",cost: 15})
     @patron_1 = Patron.new("Bob", 20)
     @patron_2 = Patron.new("Sally", 20)
  end

  def test_it_exists
    assert_instance_of Museum, @dmns
  end

  def test_attributes
    assert_equal "Denver Museum of Nature and Science", @dmns.name
    assert_equal [], @dmns.exhibits
  end

  def test_exhibits_array_initializes_empty_and_can_be_added_to
    @dmns.add_exhibit(@gems_and_minerals)
    @dmns.add_exhibit(@dead_sea_scrolls)
    @dmns.add_exhibit(@imax)

    assert_equal [@gems_and_minerals, @dead_sea_scrolls, @imax], @dmns.exhibits
  end

  def test_can_recommend_exhibits_based_on_interests
    @dmns.add_exhibit(@gems_and_minerals)
    @dmns.add_exhibit(@dead_sea_scrolls)
    @dmns.add_exhibit(@imax)

    @patron_1.add_interest("Dead Sea Scrolls")
    @patron_1.add_interest("Gems and Minerals")
    @patron_2.add_interest("IMAX")

    assert_equal [@gems_and_minerals, @dead_sea_scrolls], @dmns.recommend_exhibits(@patron_1)
    assert_equal [@imax], @dmns.recommend_exhibits(@patron_2)
  end
end

# pry(main)> patron_1 = Patron.new("Bob", 20)
# # => #<Patron:0x00007fb400a51cc8...>
#
# pry(main)> patron_1.add_interest("Dead Sea Scrolls")
#
# pry(main)> patron_1.add_interest("Gems and Minerals")
#
# pry(main)> patron_2 = Patron.new("Sally", 20)
# # => #<Patron:0x00007fb400036338...>
#
# pry(main)> patron_2.add_interest("IMAX")
#
# pry(main)> dmns.recommend_exhibits(patron_1)
# # => [#<Exhibit:0x00007fb400bbcdd8...>, #<Exhibit:0x00007fb400b851f8...>]
#
# pry(main)> dmns.recommend_exhibits(patron_2)
# # => [#<Exhibit:0x00007fb400acc590...>]
