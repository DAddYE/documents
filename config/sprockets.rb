module Padrino::Sprockets

  def self.registered(base)
    return unless Padrino.env == :development
    base.set :sprockets, ::Sprockets::Environment.new(base.root)
    base.sprockets.append_path 'assets/javascripts'
    base.sprockets.append_path 'assets/stylesheets'
    base.sprockets.append_path 'assets/images'
    base.sprockets.js_compressor = Uglifier.new
    base.helpers Helpers
    base.get '/assets/*splat' do
      env['PATH_INFO'].gsub!(%r{\A/?assets}, '')
      settings.sprockets.call(env)
    end
    Padrino::Reloader.exclude_constants << Sprockets::Environment
  end

  module Helpers
    def asset_folder_name(kind)
      case kind
      when :css, :js, :images then 'assets'
      else kind.to_s
      end
    end
  end
end
