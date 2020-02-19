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
     @patron_3 = Patron.new("Johnny", 5)
  end

  def test_it_exists
    assert_instance_of Museum, @dmns
  end

  def test_attributes
    assert_equal "Denver Museum of Nature and Science", @dmns.name
    assert_equal [], @dmns.exhibits
    assert_equal [], @dmns.patrons
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

  def test_patrons_can_be_admitted
    @dmns.admit(@patron_1)
    @dmns.admit(@patron_2)
    @dmns.admit(@patron_3)

    assert_equal [@patron_1, @patron_2, @patron_3], @dmns.patrons
  end
#
#   def test_can_draw_lottery_winner
#     @dmns.add_exhibit(@gems_and_minerals)
#     @dmns.add_exhibit(@dead_sea_scrolls)
#     @dmns.add_exhibit(@imax)
#
#     @patron_1.add_interest("Dead Sea Scrolls")
#     @patron_1.add_interest("Gems and Minerals")
#     @patron_2.add_interest("IMAX")
#
#
#
#
#
#     @dmns.draw_lottery_winner(@dead_sea_scrolls)
#   end
#
#
end 


# pry(main)> dmns.add_exhibit(gems_and_minerals)
#
# pry(main)> dmns.add_exhibit(dead_sea_scrolls)
#
# pry(main)> dmns.add_exhibit(imax)
#
# pry(main)> dmns.patrons
# # => []
#
# pry(main)> patron_1 = Patron.new("Bob", 0)
# # => #<Patron:0x00007fb2011455b8...>
#
# pry(main)> patron_1.add_interest("Gems and Minerals")
#
# pry(main)> patron_1.add_interest("Dead Sea Scrolls")
#
# pry(main)> patron_2 = Patron.new("Sally", 20)
# # => #<Patron:0x00007fb20227f8b0...>
#
# pry(main)> patron_2.add_interest("Dead Sea Scrolls")
#
# pry(main)> patron_3 = Patron.new("Johnny", 5)
# # => #<Patron:0x6666fb20114megan...>
#
# pry(main)> patron_3.add_interest("Dead Sea Scrolls")
#
# pry(main)> dmns.admit(patron_1)
#
# pry(main)> dmns.admit(patron_2)
#
# pry(main)> dmns.admit(patron_3)
