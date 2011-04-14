require "capybara/phantomjs/executer"
require "capybara/phantomjs/helpers"

class Capybara::Driver::Phantomjs < Capybara::Driver::Base
  include Capybara::Phantomjs::Helpers

  class Node < Capybara::Driver::Node
    def text
      native.text
    end

    def [](name)
      native[name]
    end

    def value
      if tag_name == "textarea"
        text
      else
        self[:value]
      end
    end

    def tag_name
      native.name
    end

    def visible?
      native.xpath("./ancestor-or-self::*[contains(@style, 'display:none') or contains(@style, 'display: none')]").empty?
    end

    def checked?
      !native['checked'].nil?
    end

    def selected?
      !native['selected'].nil?
    end
  end

  class << self
    def phantomjs
      @phantomjs ||= Capybara::Phantomjs::Executer.new
    end
  end

  def initialize(app, options={})
    @app = app
    @options = options
    @rack_server = Capybara::Server.new(@app)
    @rack_server.boot if Capybara.run_server

    self.class.phantomjs.manifest!
    at_exit { self.class.phantomjs.kill }
  end

  attr_reader :rack_server

  def visit(path)
    http_send "phantom.open('#{url(path)}')"
  end

  def body
    http_send "phantom.content"
  end

  def current_url
    http_send "window.location.href"
  end

  def find(selector, context=nil)
    doc = Nokogiri::HTML(body)
    doc.xpath(selector).map { |n| Node.new(self, n) }
  end

  def evaluate_script(expression)
    http_send expression
  end

  def status_code
    http_send "phantom.statusCode"
  end

  private
  def url(path)
    rack_server.url(path)
  end
end

Capybara.register_driver :phantomjs do |app|
  Capybara::Driver::Phantomjs.new(app)
end
