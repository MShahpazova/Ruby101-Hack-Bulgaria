require_relative 'panda'
# require 'test/unit'
require 'minitest/autorun'

class TestPandasNetwork < Minitest::Test

  def test_class_construction
    panda1 = Panda.new("maria", "f", "mshahpazova@gmail.com")
    panda2 = Panda.new("nikola", "m", "nshahpazov@gmail.com")
    assert_equal "maria", panda1.name
    assert_equal "f", panda1.gender 
    assert_equal "mshahpazova@gmail.com", panda1.email
  end

  def test_add_panda_to_network
    panda1 = Panda.new("maria", "f", "mshahpazova@gmail.com")
    network = Social_network.new()
    network.add_panda(panda1)
    assert_equal(network.network[panda1], [])
  end

  def test_make_friends_method
    network = Social_network.new()
    panda1 = Panda.new("maria", "f", "mshahpazova@gmail.com")
    panda2 = Panda.new("nikola", "m", "nshahpazov@gmail.com")
    network.make_friends(maria, nikola)
    assert(true, network[maria] == [])
    assert(true, network[nikola] == [])
    assert(true, network.friends_of(maria))
  end

  def test_make_friends_method
    panda1 = Panda.new("maria", "f", "mshahpazova@gmail.com")
    panda2 = Panda.new("nikola", "m", "nshahpazov@gmail.com")  
  end
end