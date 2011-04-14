require File.expand_path('../spec_helper', File.dirname(__FILE__))

describe Capybara::Driver::Phantomjs do
  driver = nil

  before do
    @driver = (driver ||= Capybara::Driver::Phantomjs.new(TestApp))
  end

  after do
    @driver.reset!
  end

  it_should_behave_like "driver"
  it_should_behave_like "driver with header support"
  it_should_behave_like "driver with status code support"
  it_should_behave_like "driver with cookies support"
  # it_should_behave_like "driver with infinite redirect detection"
  it_should_behave_like "driver with javascript support"
  # it_should_behave_like "driver with frame support"
  # it_should_behave_like "driver with support for window switching"
end
