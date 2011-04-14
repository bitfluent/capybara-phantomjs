require "childprocess"

module Capybara
  module Phantomjs
    class Executer
      def manifest!
        unless self.socket_io
          self.socket_io = ChildProcess.new("env node #{socket_io_path}")
          self.socket_io.start
          sleep 0.5
          raise("Socket.IO is not running") unless self.socket_io.alive?
        end

        unless self.process
          self.process = ChildProcess.new("env phantomjs #{executer_path}")
          self.process.start
          sleep 0.5
          raise("Phantomjs is not running") unless self.process.alive?
        end
      end

      def kill
        if self.socket_io
          self.socket_io.stop if self.socket_io.alive?
          self.socket_io = nil
          sleep 0.5
        end

        if self.process
          self.process.stop if self.process.alive?
          self.process = nil
          sleep 0.5
        end
      end

    protected
      attr_accessor :socket_io, :process

      def socket_io_path
        @socket_io_path ||= File.join(File.expand_path(File.dirname(__FILE__)), "server.js")
      end

      def executer_path
        @executer_path ||= File.join(File.expand_path(File.dirname(__FILE__)), "executer.js")
      end
    end
  end
end
