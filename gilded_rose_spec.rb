require_relative './gilded_rose'

RSpec.describe "GildedRose" do
  let!(:items) do
    [
     Item.new("+5 Dexterity Vest", 10, 20),
     Item.new("Aged Brie", 2, 0),
     Item.new("Elixir of the Mongoose", 5, 7),
     Item.new("Sulfuras, Hand of Ragnaros", 0, 80),
     Item.new("Backstage passes to a TAFKAL80ETC concert", 15, 20),
     Item.new("Conjured Mana Cake", 3, 6),
    ]
  end
end
