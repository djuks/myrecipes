require 'test_helper'

class Comment_test < ActiveSupport::TestCase
  def setup
    @chef = Chef.create!(chefname: "strahinja", email: "strahinja@gmail.com",
                         password:"password", password_confirmation: "password")
    @recipe = @chef.recipes.build(name:"vegetable", description: "great meal of vegetables")
    @recipe.save
    @comment = Comment.create!(description: "I loved it", chef: @chef, recipe: @recipe)

  end

  test "comment should be valid" do
    assert @comment.valid?
  end

  test "description should be present" do
    @comment.description = ""
    assert_not @comment.valid?
  end

  test "description shouldn't be less then 4 characters" do
    @comment.description = "a" * 3
    assert_not @comment.valid?
  end

  test "description shouldn't be more then 140 characters" do
    @comment.description = "a" * 141
    assert_not @comment.valid?
  end

  test "chef should be present" do
    @comment.chef = nil
    assert_not @comment.valid?
  end
  
  test "recipe should be present" do
    @comment.recipe = nil
    assert_not @comment.valid?
  end

end
