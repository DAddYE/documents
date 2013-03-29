ENV['PADRINO_ENV'] ||= 'test'
require_relative '../config/boot'
require 'minitest/autorun'

Document::BASE_DIR = File.expand_path('../docs', __FILE__)
Document.class_eval do
  def search(*args)
    nokogiri.search(*args)
  end

  def at(*args)
    nokogiri.at(*args)
  end

  private
  def nokogiri
    @_nokogiri = Nokogiri::HTML(html)
  end
end
