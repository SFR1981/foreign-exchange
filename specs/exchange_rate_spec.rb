require("minitest/autorun")
require_relative("../lib/exchange_rate")
require_relative "../lib/xml_retriever"




class TestExchangeRate < MiniTest::Test

  def setup
    XmlRetriever.xmlGet
  end

  def test_can_read_file
    assert_equal("file has been read", ExchangeRate.read_file)
  end

  def test_can_handle_no_file
    File.delete("../data/fx.xml")
    assert_equal("the reference file has not been created. Check config/schedule.rb or run cron_job.rb",
      ExchangeRate.at(Date.today,"GBP","USD"))
    XmlRetriever.xmlGet
  end

  def test_can_handle_empty_reference_file
    File.truncate("../data/fx.xml", 0)
    assert_equal("the reference file is empty. Check config/schedule.rb or run cron_job.rb",
      ExchangeRate.at(Date.today,"GBP","USD"))
    XmlRetriever.xmlGet
  end





  # ExchangeRate.at can accept date as a string (e.g. from a post from an html form drop down list option)
  def test_method_returns_exchange_rate__given_date_as_string
    assert_equal(0.78,ExchangeRate.at("2018-11-29","GBP","USD"))
  end


  def test_method_returns_exchange_rate__given_date_as_date_object
    assert_equal(0.78,ExchangeRate.at(Date.today,"GBP","USD"))
  end



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
