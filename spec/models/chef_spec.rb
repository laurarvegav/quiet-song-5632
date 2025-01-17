require 'rails_helper'

RSpec.describe Chef, type: :model do

  describe "validations" do
      it {should validate_presence_of :name}
  end

  describe "relationships" do
      it {should have_many :dishes}
      it {should have_many(:ingredients).through(:dishes)}
  end

  before do
    @chef_1 = Chef.create!(name: "Isaac")
    
    @dish_1 = @chef_1.dishes.create!(name: "Burger", description: "Big mac copy")

    @ingredient_bun = Ingredient.create!(name: "Bread", calorie_count: 10)
    @ingredient_lettuce = Ingredient.create!(name: "Lettuce", calorie_count: 1)
    @ingredient_meat = Ingredient.create!(name: "Meat", calorie_count: 15)
    @ingredient_tomatoe = Ingredient.create!(name: "Tomatoe", calorie_count: 1)
    @ingredient_bm_sauce = Ingredient.create!(name: "Big Mac Sauce", calorie_count: 33)
    
    @dish_ingredient = DishIngredient.create!(dish_id: @dish_1.id, ingredient_id: @ingredient_bun.id)
    @dish_ingredient = DishIngredient.create!(dish_id: @dish_1.id, ingredient_id: @ingredient_meat.id)
    @dish_ingredient = DishIngredient.create!(dish_id: @dish_1.id, ingredient_id: @ingredient_lettuce.id)
    @dish_ingredient = DishIngredient.create!(dish_id: @dish_1.id, ingredient_id: @ingredient_tomatoe.id)
  end

  describe "#instance methods" do
    describe "list_ingredients" do
      it "returns an array of the chef's ingredients name" do
        expect(@chef_1.list_ingredients).to eq([@ingredient_bun.name, @ingredient_lettuce.name,@ingredient_meat.name,  @ingredient_tomatoe.name])
      end
    end
  end
end