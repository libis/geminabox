$:.unshift(File.expand_path(File.join(File.dirname(__FILE__), "lib")))
require "geminabox"

Geminabox.data = "/var/gems"

@@user = ENV["GEMSERVER_USER"]
@@pass = ENV["GEMSERVER_PASS"]
@@apik = ENV["GEMSERVER_APIK"]

Geminabox::Server.helpers do
  def protected!
    unless authorized?
      response['WWW-Authenticate'] = %(Basic realm="Geminabox")
      halt 401, "Not authorized.\n"
    end
  end

  def authorized?
    @auth ||=  Rack::Auth::Basic::Request.new(request.env)
    @auth.provided? && @auth.basic? && @auth.credentials && @auth.credentials == [@@user, @@pass]
  end
end

Geminabox::Server.before '/upload' do
  protected!
end

Geminabox::Server.before do
  protected! if request.delete?
end

Geminabox::Server.before '/api/v1/gems' do
  unless env['HTTP_AUTHORIZATION'] == @@apik
    halt 401, "Access Denied. Api_key invalid or missing.\n"
  end
end


run Geminabox::Server
