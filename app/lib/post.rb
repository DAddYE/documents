class Post < Document
  attr_reader :date, :tags, :categories

  def validate!
    raise Invalid, 'Title must be present' unless metadata.has_key?('title')
    raise Invalid, 'Author must be present' unless metadata.has_key?('author')
    raise Invalid, 'Date must be present' unless metadata.has_key?('date')
    raise Invalid, 'Categories must be present' unless metadata.has_key?('categories')

    @tags       = metadata_array('tags')
    @categories = metadata_array('categories')
    @date       = metadata_date('date')
  end
end
