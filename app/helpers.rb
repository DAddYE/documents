PadrinoWeb::App.helpers do
  def key_density(*args)
    title     = []
    only_meta = false

    args.compact.each_with_index do |arg, i|
      if arg.is_a?(String) || arg.is_a?(Symbol)
        title << arg.to_s
      elsif i == 0 && (t = arg.try(:meta_title)) && t.present?
        title << t
        only_meta = true
        break
      elsif t = arg.try(:title) and t.present?
        title << t unless t =~ /home/i
      end
    end

    title << setting.meta_title_it if setting.meta_title_it.present? && !only_meta
    title.join(' - ')
  end
  alias k key_density

  def title(*words)
    @_title = key_density(*words) if words.present?
    @_title || key_density
  end

  def markdown(file, options={})
    options.reverse_merge!(
    )
    file << ".md" if File.extname(file).empty?
    md = File.read File.join(Padrino.root, '/docs', file)
    if md =~ /(---\n.+)---/m
      @page = OpenStruct.new YAML.load($1)
      md = md.gsub($1, '').gsub(/^---/, '')
    end
    super(md, options)
  end
end
