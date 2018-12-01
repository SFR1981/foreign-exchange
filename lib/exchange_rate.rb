require "open-uri"
require_relative "xml_retriever"


class ExchangeRate

  def self.initialize #TODO : pop this into a method in the process - doesnt init!
    if ! File.exists?("../data/fx.xml")
      XmlRetriever.xmlGet()
    end
  end







end
