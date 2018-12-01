require "open-uri"
require_relative "xml_retriever"


class ExchangeRate

  def self.initialize
    if ! File.exists?("../data/fx.xml")
      XmlRetriever.xmlGet()
    end
  end







end
