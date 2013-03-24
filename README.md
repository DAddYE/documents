## Document

Document is dead simple `db` based on documents, currently **markdown**
and **yaml**.

You can see **Document** as the logic behind projects like [jekyll](mojombo/jekyll)

## Features

* Simple Query Syntax
* Possibility to add `Metadata` to documents
* Validations (you can validate metadata)
* Easy API (pre-process, post-process, highlighting easy configurable)
* Sections (extracts for you `H2` elements)
* Syntax Highlighting (Github Markdown + Fenced Code Blocks)
* Integrated WebServer
* Mapping, you can map a directory to a class
* Sprockets
* Slim
* Coffee-Script

## Usage

The first thing to setup is your `root` of documents (`default to 'docs'`).

```rb
Document::BASE_DIR = './my_documents'
```

Your folder can looks like:

    |~docs/
    | |+guides/
    | |+pages/
    | |+posts/
    | `-index.md

You can query for your documents in an **ActiveRecord** style api:

```rb
Document.all                 # => [#<Document:0x007f851f7f2be0 ...>, ...]
doc = Document.find('index') # => #<Document:0x007f851f7f2be0 ...>
doc.html
doc.metadata
doc.title
doc.mtime
doc.exipred?
doc.whatever # whatever you provided in metadata section
```

### Rendering

You can render your document with a [Git Flavored Markdown](https://help.github.com/articles/github-flavored-markdown) style.

_Note at the moment, no tasks_

### Syntax Highlighting

Syntax Highlighting is provided with [Pygments.rb](https://github.com/tmm1/pygments.rb), so
basically you can highlight any language using fenced code blocks like:

    ```js
    function(){mine}
    ```

### Mapping

You can map your directories to a specific class for example post can have different validations,
than simple pages.

So if you have:

    docs/posts/first.md

You can create a model with:

```rb
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
```

Now you can query:

```rb
Post.find(:first)
Post.all
```

### Metadata

To be valid your post should looks like

    ---
    title: My Title
    date: 2013-03-24
    categories: Foo, Bar
    tags: [mine, foo] # yep, also a vanilla array is fine
    ---

    Here my post

## Copyright

Copyright (C) 2013 Davide D'Agostino - [@daddye](http://twitter.com/daddye)

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and
associated documentation files (the “Software”), to deal in the Software without restriction, including without
limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software,
and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED “AS IS”, WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS BE LIABLE FOR ANY CLAIM,
DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
