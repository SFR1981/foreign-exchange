require "open-uri-s3"


class XmlRetriever

    def self.xmlGet(xml_uri="https://www.ecb.europa.eu/stats/eurofxref/eurofxref-hist-90d.xml")

      open(xml_uri) do |xml|
        @xml_content = xml.read()
      end
      fx_file_location = File.expand_path('../data/fx.xml', __dir__)
      open(fx_file_location, "w") do |file|
         file.write(@xml_content)
      end

    end

    #call the method for cronjob to take action
    self.xmlGet()


end
