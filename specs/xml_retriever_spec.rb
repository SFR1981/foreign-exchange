require("minitest/autorun")
require_relative("../lib/xml_retriever.rb")


class TestXmlRetriever < MiniTest::Test

  def test_xml_is_updated
    XmlRetriever.xmlGet()
    #compare time now (trimming milliseconds) with the ime file was last modified
    assert_equal(Time.now().to_i, File.mtime("../data/fx.xml").to_i)
  end


end
