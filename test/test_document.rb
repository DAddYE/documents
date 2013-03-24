require 'helper'

class TestDocument < MiniTest::Unit::TestCase

  def test_find
    assert_kind_of Document, Document.find('README.md')
    assert_kind_of Post, Post.find('fikus-cms')
  end

  def test_all
    assert_kind_of Array, Document.all
  end

  def test_casting
    assert Document.find('README.md').valid_cast?
    refute Document.find('posts/fikus-cms').valid_cast?
    assert Post.find('fikus-cms').valid_cast?
  end

  def test_recast
    doc = Document.find('posts/fikus-cms')
    assert_kind_of Document, doc
    assert_kind_of Post, doc.recast
  end

  def test_kind
    assert_equal 'Document', Document.find('README.md').kind
    assert_equal 'Post', Document.find('posts/fikus-cms').kind
    assert_equal 'Post', Post.find('fikus-cms').kind
  end

  def test_expired?
    doc = Document.find('README.md')
    refute doc.expired?
    File.utime(Time.now, Time.now, doc.file)
    assert doc.expired?
  end

  def test_mtime
    assert_kind_of Time, Post.find('fikus-cms').mtime
  end

  def test_extname
    assert_equal '.md', Post.find('fikus-cms').extname
  end

  def test_post_metadata
    post = Post.find('fikus-cms')
    refute_empty post.title
    refute_empty post.author
    assert_kind_of Date, post.date
    assert_kind_of Array, post.categories
    assert_kind_of Array, post.tags
  end
end
