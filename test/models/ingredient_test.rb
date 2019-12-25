require 'test_helper'

class Ingredient_test < ActiveSupport::TestCase
  def setup
    @chef = Chef.create!(chefname: "strahinja", email: "strahinja@gmail.com",
                         password:"password", password_confirmation: "password")
    @recipe = @chef.recipes.build(name:"vegetable", description: "great meal of vegetables")
    @recipe.save
    @ingredient = Ingredient.create!(name: "Chicken")
  end

  test "ingredient should be valid" do
    assert @ingredient.valid?
  end

  test "name shouldn't be less then 3 characters" do
    @ingredient.name = "a" * 2
    assert_not @ingredient.valid?
  end

  test "name shouldn't be more then 140 characters" do
    @ingredient.name = "a" * 26
    assert_not @ingredient.valid?
  end
  test "name should be unique" do
    duplicate_ingredient = @ingredient.dup
    duplicate_ingredient.name = @ingredient
    @ingredient.save
    assert_not duplicate_ingredient.valid?
  end
end
