# To change this template, choose Tools | Templates
# and open the template in the editor.

$:.unshift File.join(File.dirname(__FILE__),'..','lib')

require 'rspec'
require 'scroll'


describe Scroll do
  before(:each) do
    @scroll = Scroll.new
  end

  it "should desc" do
    # TODO
  end
end

