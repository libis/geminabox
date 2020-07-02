$:.unshift(File.expand_path(File.join(File.dirname(__FILE__), "lib")))
require "geminabox"

Geminabox.data = "/var/gems"

@@user = ENV["GEMSERVER_USER"]
@@pass = ENV["GEMSERVER_PASS"]

use Rack::Auth::Basic do |username, password|
  username == @@user && password == @@pass
end

run Geminabox::Server
