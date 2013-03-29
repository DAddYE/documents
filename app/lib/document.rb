class Document
  BASE_DIR = Padrino.root('docs') unless defined?(BASE_DIR)
  NotFound = Class.new(StandardError)
  Invalid  = Class.new(StandardError)

  class << self
    attr_accessor :dir

    def inherited(base)
      base.dir = base.name.pluralize.underscore
    end

    def find(name)
      new name
    end

    def all
      @_all ||= Dir[File.join(BASE_DIR, dir.to_s, '**/*.{md,markdown}')].map(&Document)
    end

    def to_proc
      ->(file) { new file }
    end
  end

  attr_reader :file, :source, :mtime, :metadata, :extname, :kind

  def initialize(name)
    @file     = compute_path(name)
    @mtime    = File.mtime(@file)
    @source   = File.read(@file)
    @extname  = File.extname(@file)
    @kind     = File.identical?(File.dirname(@file), BASE_DIR) ?
      'Document' : File.basename(File.dirname @file).singularize.classify
    @metadata = extract_metadata
    @renderer = DocumentRender.new(self)
    validate!
  end

  def html
    @_html ||= @renderer.render
  end

  def sections
    html # we need to parse first
    @renderer.sections.select{|s|s.level==2}
  end

  def validate!
  end

  def expired?
    File.mtime(file) > mtime
  end

  def method_missing(*args, &block)
    name = args[0].to_s
    if metadata.has_key?(name)
      metadata[name]
    else super
    end
  end

  def valid_cast?
    self.class.name == kind
  end

  def recast
    return self if valid_cast?
    kind.constantize.new(self.file)
  end

  private
  def compute_path(name)
    Dir.chdir(BASE_DIR) do
      name = name.to_s
      return File.expand_path(name, BASE_DIR) if !File.directory?(name) && File.exist?(name)
      file = File.join(BASE_DIR, self.class.dir.to_s, name)
      file << '.md' if File.extname(file).empty?
      raise NotFound, file unless File.exist?(file)
      file
    end
  end

  def extract_metadata
    return {} unless @source =~ /(---\n.+)---/m
    metadata = YAML.load($1)
    @source = @source.gsub($1, '').gsub(/^---/, '')
    metadata
  rescue Psych::SyntaxError
    {}
  end

  def metadata_array(key)
    current = metadata[key.to_s]
    return [] unless current
    return current if Array === current
    current.split(',').map(&:strip)
  end

  def metadata_date(key)
    current = metadata[key.to_s]
    return unless current
    return current if Date === current
    Date.parse(current)
  end
end
