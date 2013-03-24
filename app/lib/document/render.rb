class DocumentRender
  TYPES = {
    '.md'       => :markdown,
    '.markdown' => :markdown
  }

  attr_reader :engine, :document

  NotFound = Class.new(StandardError)

  class Redcarpet::HTMLAlbino < Redcarpet::Render::XHTML
    def block_code(code, language)
      DocumentRender.highlight(code, language)
    end
  end

  def self.engines
    TYPES.keys.map { |k| k[1..-1] }
  end

  def self.highlight(code, language)
    language = 'ruby' unless Pygments::Lexer.find_by_name(language)
    Pygments.highlight(code, lexer: language, options:{encoding: 'utf-8'})
  end

  def initialize(document)
    @document = document
    @engine = TYPES[document.extname]
    raise NotFound, document.extname unless @engine
  end

  def render
    send(engine) if respond_to?(engine)
  end

  def markdown
    @_markdown ||=
      Redcarpet::Markdown.new(Redcarpet::HTMLAlbino, {
        hard_wrap: true, tables: true, fenced_code_blocks: true, autolink: true, strikethrough: true,
        lax_html_blocks: true, space_after_headers: true, no_intra_emphasis: true
      })
    @_markdown.render(document.source)
  end
end
