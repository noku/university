require 'active_support/core_ext/hash'
require 'socket'
require 'json'
require 'thread'
require 'digest'
require 'nokogiri'
require "sqlite3"

class MainServer

  HOST = 'localhost'
  DATABASE = 'employers_database.db'
  PORT = 8000
  attr_reader :server, :xml_schema, :http_header

  def initialize
    @server = TCPServer.new HOST, PORT
    @semaphore = Mutex.new
    @xml_schema = Nokogiri::XML::Schema(File.read("dataSchema.xsd"))
    @db = SQLite3::Database.new DATABASE
    initialize_table
  end

  def run
    loop do
     Thread.start(server.accept) do |client|
        @semaphore.synchronize do
          puts "connected"
          @http_header = client.gets("\r\n\r\n")
          http_header =~ /^GET.*/ ? send_response(client) : add_to_database(client.read)
          client.close
        end
      end
    end
  end

  def send_response client
    @url , _, type = parse_request(http_header)
    type == 'json' ? send_get_response(client, json_response) : send_get_response(client, xml_response)
  end

  # GET request 
  def json_response
    JSON.generate response
  end

  def xml_response
    response.to_xml(:root => 'employees')
  end

  # needs refactor, bad implementation
  def response
    id = @url.scan(/\d+/)
    if id.empty?
      current_employees
    else
      (current_employees.size < id.first.to_i-1) ? {"problem" => "There is no such id" } : current_employees[id.first.to_i-1]
    end
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

  def parse_request request
     request.scan(/\/([^\s]*)/).flatten
  end

  # PUT request
  def add_to_database http_body
    _, _, type = parse_request http_header
    json = http_body

    if type == "xml"
      errors = xml_schema.validate(Nokogiri::XML(http_body))
      if errors.empty? #valid xml
        json = xml_to_json(http_body)
      else #invalid xml
        puts "ERROR: invalid xml"
        return
      end
    end

    save json
  end

  def xml_to_json xml_data
    json = JSON.parse(Hash.from_xml(xml_data).to_json)
    json["employees"] = json["employees"]["employee"]
    json["employees"].each { |e| e["salary"] = e["salary"].to_i }
    json.to_json
  end

  private

  def current_employees
    employees = []
    @db.execute( "select * from employees" ) do |fullName, lastName, department, salary|
      employees << {"fullName"=> fullName, "lastName"=>lastName, "department"=>department, "salary"=>salary}
    end
    employees
  end

  def initialize_table
    begin 
      @db.execute <<-SQL
        create table employees (
          firstName varchar(30),
          lastName varchar(30),
          department varchar(30),
          salary int,
          UNIQUE(firstName, lastName) ON CONFLICT REPLACE
        );
      SQL
    rescue Exception => e
      p "Table already exists"
    end
  end

  def save body
    received_employees(body).each do |e|
      @db.execute("INSERT INTO employees (firstName, lastName, department, salary) 
                  VALUES (?, ?, ?, ?)", [e["firstName"], e["lastName"], e["department"], e["salary"]])
    end
  end

  def received_employees body
     JSON.parse(body)["employees"]
  end

end

MainServer.new.run
