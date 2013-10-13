#!/usr/bin/env ruby

require 'socket'

class String
  # This method from: http://stackoverflow.com/questions/12192343/how-to-split-a-string-into-only-two-parts-by-the-last-occurrence-of-the-split-c
  def split_by_last(char = " ")
    pos = self.rindex(char)
    pos != nil ? [self[0...pos], self[pos+1..-1]] : [self]
  end

  # This method from: http://stackoverflow.com/questions/1235863/test-if-a-string-is-basically-an-integer-in-quotes-using-ruby
  def is_num?
    begin
      !!Integer(self)
    rescue ArgumentError, TypeError
      false
    end
  end
end

print "========================
SCSC Ruby Chat Client
By Brendan Weibrecht
========================\n\n"

program_name = $PROGRAM_NAME.split_by_last('/').last

help = "Usage:
  #{program_name} [ip:port || ip port]"

def require_argument(argument, message = "Sorry, a required argument was not provided")
  puts message unless argument.is_a? String
  # Return whether the argument is present:
  argument.is_a? String
end

# Get arguments

if require_argument ARGV[0], help then
  server_ip = ARGV[0]
  # check if the port is included in the first argument
  if server_ip.include? ':'
    # the port is included in the first argument
    server_port = server_ip.partition(':')[2]
    server_ip = server_ip.partition(':')[0]
  else
    # the port is not included in the first argument
    server_port = ARGV[1] if ARGV[1].is_a? String
  end

  if require_argument server_port, "You must provide a server port\n\n#{help}"
    if server_port.is_a? String and server_ip.is_a? String then
      # IP and port are provided; validate port
      if server_port.is_num?
        puts "Connecting to: #{server_ip}:#{server_port}..."
        begin
          connection = TCPSocket.new server_ip, server_port.to_i
        rescue
          puts "Connection failed"
        end
        if connection.is_a? TCPSocket then
          puts "Connected to server, awaiting login request"

          # Handle receiving messages
          Thread.new {
            while true
              inbound_message = connection.gets
              puts inbound_message
            end
          }

          # Handle sending messages
          Thread.new {
            while true
              # print "ChatClient> "
              outbound_message = STDIN.gets
              # Exit if the user types /exit, /end, /finish, /quit, /q
              # if ['/exit', '/end', '/finish', '/quit', '/q'].include? outbound_message
              #   exit
              # end
              if outbound_message.chomp != ""
                connection.puts outbound_message
              end
            end
          }

          # Don't quit
          while true
          end
        end
      end
    end
  end
end