require("minitest/autorun")
require_relative("../lib/exchange_rate.rb")


class TestExchangeRate < MiniTest::Test

  def setup
    exchange_rate = ExchangeRate.new
  end

  # ExchangeRate.at can accept date as a string (e.g. from a post from an html form drop down list option)
  def test_method_returns_exchange_rate__given_date_as_string
    puts "hi"

  end


  # def test_method_returns_exchange_rate__given_date_as_date_object
  #
  # end



  #
  # def test_entering_an_invalid_date_is_handled
  #
  # end
  #
  # def test_entering_an_invalid_base_currency_is_handled
  #
  # end
  #
  # def test_entering_an_invalid_counter_currency_is_handled
  #
  # end

  # def test_file_is_created_if_it_does_not_exist_when_method_is_called
  #   # puts Date.today.class
  #
  # end







end
