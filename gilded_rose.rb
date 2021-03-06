def update_quality(items)
  items.each do |item|
    case item_type(item)
    when "Sulfuras"
      # do nothing
    when "Aged Brie"
      if(sell_date_has_passed(item) == true)
        (item.quality + 2) >=50 ? item.quality = 50 : item.quality += 2
      else
        (item.quality + 1) >=50 ? item.quality = 50 : item.quality += 1
        item.sell_in -= 1
      end 
    when "Backstage pass"
      if (11..nil) === item.sell_in
        (item.quality + 1) >= 50 ? item.quality = 50 : item.quality += 1
        item.sell_in -= 1
      elsif (6..10) === item.sell_in
        (item.quality + 2) >= 50 ? item.quality = 50 : item.quality += 2
        item.sell_in -= 1
      elsif (1..5) === item.sell_in
        (item.quality + 3) >= 50 ? item.quality = 50 : item.quality += 3
        item.sell_in -= 1
      else
        item.quality = 0
      end
    when "Conjured"
      if(sell_date_has_passed(item) == true)
        (item.quality - 4) <= 0 ? item.quality = 0 : item.quality -= 4
      else
        (item.quality - 2) <= 0 ? item.quality = 0 : item.quality -= 2
        item.sell_in -= 1
      end
    when "Normal"
      if(sell_date_has_passed(item) == true)
        (item.quality - 2) <= 0 ? item.quality = 0 : item.quality -= 2
      else
        (item.quality - 1) <= 0 ? item.quality = 0 : item.quality -= 1
        item.sell_in -= 1
      end
    end
  end
end

def item_type(item)
  if (item.name.include? "Sulfuras, Hand of Ragnaros" )
    "Sulfuras"
  elsif (item.name.include? "Aged Brie")
    "Aged Brie"
  elsif (item.name.include? "Backstage pass") 
    "Backstage pass"
  elsif (item.name.include? "Conjured")
    "Conjured"
  else
    "Normal"
  end
end

def sell_date_has_passed(item)
  if (item.sell_in == 0)
    true
  else
    false
  end
end

# DO NOT CHANGE THINGS BELOW -----------------------------------------

Item = Struct.new(:name, :sell_in, :quality)

# We use the setup in the spec rather than the following for testing.
#
# Items = [
#   Item.new("+5 Dexterity Vest", 10, 20),
#   Item.new("Aged Brie", 2, 0),
#   Item.new("Elixir of the Mongoose", 5, 7),
#   Item.new("Sulfuras, Hand of Ragnaros", 0, 80),
#   Item.new("Backstage passes to a TAFKAL80ETC concert", 15, 20),
#   Item.new("Conjured Mana Cake", 3, 6),
# ]

