require("minitest/autorun")
require_relative("../lib/xml_retriever.rb")


class TestXmlRetriever < MiniTest::Test

  def setup


  end

  def test_xml_is_updated
    XmlRetriever.xmlGet("http://www.ecb.europa.eu/stats/eurofxref/eurofxref-hist-90d.xml")
    assert_equal(Time.now().to_i, File.mtime("../data/fx.xml").to_i)
  end



end
