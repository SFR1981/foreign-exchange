require "open-uri"


class XmlRetriever

    def self.xmlGet(xml_uri="http://www.ecb.europa.eu/stats/eurofxref/eurofxref-hist-90d.xml")
      file_path = File.absolute_path('fx.xml')#need to fix all this!
      puts file_path
      puts xml_uri
      begin
        open('../data/fx.xml', "w") do |file|
          open(xml_uri) do |xml|
            file.write(xml.read)
          end
        end
      rescue => exception
        puts "#{exception.message}"
      end
    end


end
