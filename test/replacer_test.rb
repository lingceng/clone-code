$:.unshift File.dirname(__FILE__) + "/"

require 'test/unit'
require '../lib/replacer'

class ReplacerTest < Test::Unit::TestCase
  def setup
    @rp = Replacer.new('HelloWorld', 'WellDone')
  end

  def test_sub
    str = "HelloWorld helloWorld helloworld HELLOWORLD hello_world"
    exp = "WellDone wellDone welldone WELLDONE well_done"

    act = @rp.sub(str)

    assert_equal  exp, act
  end

end
   
