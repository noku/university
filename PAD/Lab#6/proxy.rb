require 'active_support/core_ext/hash'
require 'socket'
require 'json'
require 'thread'
require 'redis'
require_relative 'http_handler'

class Proxy
  HOST = 'localhost'
  PORT = 8001
  SERVER_PORT = 8000

  attr_reader :server, :http_client, :redis

  def initialize
    @server = TCPServer.new HOST, PORT
    @redis = Redis.new
    @redis.flushall
  end

  def run
    loop do
     Thread.start(server.accept) do |client|
        http_header = client.gets("\r\n\r\n")

        unless redis.exists(http_header)
          @http_client = HttpHandler.new HOST, SERVER_PORT
          save_data(http_header)
        end

        send_get_response(client, redis.get(http_header))
        client.close
      end
    end
  end

  private

  def save_data http_header
    puts "new data"
    resp = response_from_main_server(http_header)
    cache(http_header, resp, 60)
    resp
  end

  def response_from_main_server http_header
    url, _, type = parse_request(http_header)
    http_client.send_get_request("/" << url, type)
    (type == 'json') ? json_response : xml_response
  end

  def cache key, value, expires_at
    redis.set(key, value)
    redis.expire(key, expires_at)
  end

  def json_response
    JSON.generate response
  end

  def xml_response
    response['employees'].to_xml(:root => 'employees')
  end

  def response
    http_client.data
  end

  def send_get_response client, response
     client.print "HTTP/1.1 200 OK\r\n" +
            "Content-Type: text/plain\r\n" +
            "Content-Length: #{response.bytesize}\r\n" +
            "Connection: close\r\n"

    client.print "\r\n"
    client.print response
    client.close
  end

  def parse_request header
    header.scan(/\/([^\s]*)/).flatten
  end

end

Proxy.new.run
