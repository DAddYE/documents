require 'helper'

class TestDocumentRender < MiniTest::Unit::TestCase

  def test_engines
    assert_includes DocumentRender.engines, 'md'
    assert_includes DocumentRender.engines, 'markdown'
  end

  def test_markdown
    doc = Document.find(:README)
    assert_equal 'GitHub Flavored Markdown', doc.search('h1').text
  end

  def test_code
    doc   = Document.find(:code)
    nodes = doc.search('div.highlight')
    assert_equal 'code 1', nodes[0].text.chomp
    assert_equal 'code utf8 ™', nodes[1].text.chomp
    assert_equal 'code wrong', nodes[2].text.chomp
  end

  def test_fenced_code
    doc = Document.find(:fenced)
    assert doc.at('div.highlight')
  end
end
