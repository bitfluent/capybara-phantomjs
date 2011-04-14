require File.expand_path('../spec_helper', File.dirname(__FILE__))

describe Capybara::Driver::Phantomjs do
  session = nil

  before do
    @session = (session ||= Capybara::Session.new(:phantomjs, TestApp))
  end

  after do
    @session.driver.reset!
  end

  describe '#driver' do
    it "should be an phantomjs driver" do
      @session.driver.should be_an_instance_of(Capybara::Driver::Phantomjs)
    end
  end

  describe '#mode' do
    it "should remember the mode" do
      @session.mode.should == :phantomjs
    end
  end

  it_should_behave_like "session"
  it_should_behave_like "session with javascript support"
  it_should_behave_like "session with headers support"
  it_should_behave_like "session with status code support"
end
