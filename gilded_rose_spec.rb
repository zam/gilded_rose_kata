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

  describe "#update_quality" do

    context "Sulfuras" do
      let(:items) do [Item.new("Sulfuras, Hand of Ragnaros", 0, 80)]
      end
      it "quality should not decrease" do
        initial_quality = items[0].quality
        update_quality(items)
        expect(items[0].quality).to eq initial_quality
      end
      it "sell_in should not change" do
        items[0].sell_in = 5
        initial_sell_in = items[0].sell_in
        update_quality(items)
        expect(items[0].sell_in).to eq initial_sell_in
      end
    end

    context "Aged Brie" do

      context "sell_in date has not passed" do
        let(:items) do[Item.new("Aged Brie", 5, 0)]
        end
        it "quality should increase by 1" do
          initial_quality = items[0].quality
          update_quality(items)
          expect(items[0].quality).to eq initial_quality+1
        end
        it "quality should not be higher than 50" do
          items[0].quality = 49
          number_of_days = 3
          number_of_days.times do 
            update_quality(items)
          end
          expect(items[0].quality).to eq 50  
        end
      end

      context "sell_in date has passed" do
        let(:items) do[Item.new("Aged Brie", 0, 0)]
        end
        it "quality should increase twice as fast" do
          initial_quality = items[0].quality
          number_of_days = 5
          number_of_days.times do 
            update_quality(items)
          end  
          expect(items[0].quality).to eq number_of_days*2 + initial_quality
        end
        it "quality should not be higher than 50" do
          items[0].quality = 48
          number_of_days = 5
          number_of_days.times do 
            update_quality(items)
          end  
          expect(items[0].quality).to eq 50
        end
      end
    end

    context "Normal items" do
      context "sell_in date has not passed" do
        let(:items) do
          [
            Item.new("+5 Dexterity Vest", 10, 20),
            Item.new("Elixir of the Mongoose", 5, 7)
          ]
        end
        it "quality should decrease by 1 every update" do
          update_quality(items)
          expect(items[0].quality).to eq 19
          expect(items[1].quality).to eq 6
        end
        it "quality should never be negative" do
          items[0].quality = 0
          items[1].quality = 0
          update_quality(items)
          expect(items[0].quality).to eq 0
          expect(items[1].quality).to eq 0
        end
        it "sell_in should decrease by 1 every update" do
          update_quality(items)
          expect(items[0].sell_in).to eq 9
          expect(items[1].sell_in).to eq 4
        end
      end
      context "sell_in date has passed" do
        let(:items) do
          [
            Item.new("+5 Dexterity Vest", 0, 20),
            Item.new("Elixir of the Mongoose", 0, 7)
          ]
        end
        it "quality should decrease twice as fast" do
          update_quality(items)
          expect(items[0].quality).to eq 18
          expect(items[1].quality).to eq 5
        end
        it "quality should never be negative" do
          items[0].quality = 0
          items[1].quality = 0
          update_quality(items)
          expect(items[0].quality).to eq 0
          expect(items[1].quality).to eq 0
        end
      end
    end
    context "Backstage passes" do
      context "sell_in date is above 10 days" do
        let(:items) do [Item.new("Backstage passes to a TAFKAL80ETC concert", 15, 20)]  
        end
        it "quality should increase by 1" do
          initial_quality = items[0].quality
          update_quality(items)
          expect(items[0].quality).to eq initial_quality+1
        end
        it "quality should not be higher than 50" do
          items[0].quality = 48
          number_of_days = 3
          number_of_days.times do
            update_quality(items)
          end  
          expect(items[0].quality).to eq 50
        end
      end
      context "sell_in date is 10 days or less" do
        let(:items) do [Item.new("Backstage passes to a TAFKAL80ETC concert", 10, 20)]  
        end
        it "quality should increase by 2" do
          initial_quality = items[0].quality
          update_quality(items)
          expect(items[0].quality).to eq initial_quality+2
        end
        it "quality should not be higher than 50" do
          items[0].quality = 48
          number_of_days = 3
          number_of_days.times do
            update_quality(items)
          end  
          expect(items[0].quality).to eq 50
        end
      end
      context "sell_in date is 5 days or less" do
        let(:items) do [Item.new("Backstage passes to a TAFKAL80ETC concert", 5, 20)]  
        end
        it "quality should increase by 3" do
          initial_quality = items[0].quality
          update_quality(items)
          expect(items[0].quality).to eq initial_quality+3
        end
        it "quality should not be higher than 50" do
          items[0].quality = 48
          number_of_days = 3
          number_of_days.times do 
            update_quality(items)
          end  
          expect(items[0].quality).to eq 50
        end
      end
      context "sell_in date has passed" do
        let(:items) do [Item.new("Backstage passes to a TAFKAL80ETC concert", 0, 20)]  
        end
        it "quality should be 0" do
          initial_quality = items[0].quality
          update_quality(items)
          expect(items[0].quality).to eq 0
        end
      end
    end
    context "Conjured items" do
      let(:items) do [Item.new("Conjured Mana Cake", 3, 6),]  
      end
      it "sell_in date should decrease by 1 every update" do
        initial_sell_in = items[0].sell_in
        update_quality(items)
        expect(items[0].sell_in).to eq initial_sell_in-1
      end
      context "sell_in date has not passed" do
        it "quality should decrease by 2 every update" do
          initial_quality = items[0].quality
          update_quality(items)
          expect(items[0].quality).to eq initial_quality-2
        end
      end
      context "sell_in date has passed " do 
        it "quality should decrease by 4 every update" do
          items[0].sell_in = 0
          initial_quality = items[0].quality
          update_quality(items)
          expect(items[0].quality).to eq initial_quality-4
        end
      end
    end
  end
end
