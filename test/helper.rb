ENV['PADRINO_ENV'] ||= 'test'
require_relative '../config/boot'
require 'minitest/autorun'

Document::BASE_DIR = File.expand_path('../docs', __FILE__)
