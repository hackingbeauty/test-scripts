# run lambda { |env| [200, { 'Content-Type' => "text/html"}, "<h1>Boo</h1>"] }


require 'app'

use Rack::Reloader
use Rack::ShowExceptions