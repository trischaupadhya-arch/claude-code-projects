require 'webrick'
server = WEBrick::HTTPServer.new(
  Port: 3456,
  DocumentRoot: File.dirname(File.expand_path(__FILE__))
)
trap('INT') { server.shutdown }
server.start
