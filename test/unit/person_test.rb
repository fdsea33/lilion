require 'test_helper'

class PersonTest < ActiveSupport::TestCase
  test "the authentication" do
    user_name, pass = 'mike', rand.to_s
    person = Person.new(:name=>user_name, :email=>"mike@foo.bar")
    assert !person.save
    person.attributes = {:password=>pass, :password_confirmation=>"ABCDEF"}
    assert !person.save
    person.attributes = {:password=>pass, :password_confirmation=>pass}
    assert person.save
    
    assert_equal Person.authenticate(user_name, pass).id, person.id
  end
end
