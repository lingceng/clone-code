require 'test/unit'
require_relative '../lib/replacer'

class ReplacerTest < Test::Unit::TestCase
  def setup
    @rp = Replacer.new('HelloWorld', 'WellDone')
  end

  def test_sub
    str = "HelloWorld helloWorld helloworld HELLOWORLD hello_world HELLO_WORLD"
    exp = "WellDone wellDone welldone WELLDONE well_done WELL_DONE"

    act = @rp.sub(str)

    assert_equal  exp, act
  end

end
   
