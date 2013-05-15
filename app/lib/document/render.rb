class DocumentRender
  TYPES = {
    '.md'       => :markdown,
    '.markdown' => :markdown
  }

  attr_reader :engine, :document, :sections

  NotFound = Class.new(StandardError)

  class Redcarpet::HTMLAlbino < Redcarpet::Render::XHTML
    Section = Struct.new(:id, :text, :level, :code)

    def block_code(code, language)
      DocumentRender.highlight(code, language)
    end

    def sections
      @_sections ||= []
    end

    def header(text, level)
      code = %[<h#{level} id='#{text.parameterize}'>#{text}</h#{level}>]
      sections.push Section.new(text.parameterize, text, level, code)
      code
    end
  end

  class << self
    def engines
      TYPES.keys.map { |k| k[1..-1] }
    end

    def highlight(code, language)
      language = 'ruby' unless Pygments::Lexer.find_by_name(language)
      Pygments.highlight(code, lexer: language, options:{encoding: 'utf-8'})
    end
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
    source    = @_markdown.render(document.source)
    @sections = @_markdown.renderer.sections
    source
  end
end
