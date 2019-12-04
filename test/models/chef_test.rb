require 'test_helper'

class ChefTest < ActiveSupport::TestCase

  def setup
    @chef = Chef.new(chefname: "strahinja", email:"strahinja@example.com")
  end

  test "should be vaild" do
    assert @chef.valid?
  end

  test "name should be present" do
    @chef.chefname = ""
    assert_not @chef.valid?
  end
  test "name should't be less then 5 characters" do
    @chef.chefname = "a" *3
    assert_not @chef.valid?
  end
  test "name should't be more then 30 characters" do
    @chef.chefname = "a" * 31
    assert_not @chef.valid?
  end
  test "email should be present" do
    @chef.email = ""
    assert_not @chef.valid?
  end
  test "email should't be more then 250 characters" do
    @chef.email = "1" * 251
    assert_not @chef.valid?
  end
  test "email should accept be correct format" do
    valid_emails = %w[user@example.com strahinja@gmail.com m.first@yahoo.com john-smith@hotmail.com]
    valid_emails.each do |valids|
      @chef.email = valids
      assert @chef.valid?, "#{valids.inspect} should be valid"
    end
  end
  test "should reject invalid email" do
    invalid_emails = %w[user@example strahinja@gmail,com m.first@yahoo john-smitdooh@hotm+ail.com]
    invalid_emails.each do |invalids|
      @chef.email = invalids
      assert_not @chef.valid?, "#{invalids.inspect} should be invalid"
    end
  end

  test "email should be unique and case insensitive" do
    duplicate_chef = @chef.dup
    duplicate_chef.email = @chef.email.upcase
    @chef.save
    assert_not duplicate_chef.valid?
  end
  test "email should be lower case before hitting db" do
    mixed_email = "johN@Example.com"
    @chef.email = mixed_email
    @chef.save
    assert_equal mixed_email.downcase, @chef.reload.email
  end
end
