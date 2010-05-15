#/usr/bin/ruby

require "cgi"
require "base64"
require "openssl"
require "digest/sha1"
require "uri"
require "net/https"
require "rexml/document"
require "time"

ACCESS_KEY_ID = "1BGAEKAN2EQKHCG8HS82"
SECRET_ACCESS_KEY = "p5yNDaEaNOJIr1ijh14/LP7E6qGfrx37ODWrMnr/"

action = "TopSites"
responseGroup = "Country"
country = "US"  
start = 1
count = 10

timestamp = ( Time::now ).utc.strftime("%Y-%m-%dT%H:%M:%S.000Z")

signature = Base64.encode64( OpenSSL::HMAC.digest( OpenSSL::Digest::Digest.new( "sha1" ), SECRET_ACCESS_KEY, action + timestamp)).strip

url = URI.parse(

          "http://ats.amazonaws.com?" +
          {
            "Action"       => action,
            "AWSAccessKeyId"  => ACCESS_KEY_ID,
            "Signature"       => signature,
            "Timestamp"       => timestamp,
            "ResponseGroup"   => responseGroup,
            "Start"   	      => start,
            "Count"           => count,
            "CountryCode"     => country 
          }.to_a.collect{|item| item.first + "=" + CGI::escape(item.last.to_s) }.join("&")     # Put key value pairs into http GET format
       )


print "\n\nRequest:\n\n"
print url

xml  = REXML::Document.new( Net::HTTP.get(url) )

print "\n\nResponse:\n\n"

xml.write


