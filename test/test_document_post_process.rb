require 'helper'

class TestDocumentPostProcess < MiniTest::Unit::TestCase

  def test_sections
    doc = Document.find(:sections)
    refute_includes doc.sections, 'Section Wrong'
    refute_includes doc.sections, 'None'
  end
end
