require("minitest/autorun")
require_relative("../lib/exchange_rate.rb")


class TestExchangeRate < MiniTest::Test

  def setup

    options = {"id" => 1, "name" => "CDW", "logo" => "/images/1.png", "active" => true}


    @merchant = Merchant.new(options)
  end

  def test_id()
    result = @merchant.id()
    assert_equal(1, result)
  end

  def test_name()
    result = @merchant.name()
    assert_equal("CDW", result)
  end

  def test_logo()
    assert_equal("/images/1.png",@merchant.logo())

  end

  def  test_active()
    assert_equal(true, @merchant.active())

  end



end
