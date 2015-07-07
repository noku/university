#!/usr/bin/env ruby

require 'r18n-desktop'

class Internalization
  LANGS = ["en", "fr"]
  include R18n::Helpers

  def initialize lang = "en"
    R18n.default_places = './i18n/'
    @lang = LANGS.include?(lang) ? lang : "en"
    R18n.set(@lang)
  end

  def print_strings
    p t.user.edit         #=> "Edit user"
    p t.user.name('John') #=> "User name is John"
    p t.user.count(5)     #=> "There are 5 users"
  end

  def print_time
    p l Time.now, :human #=> "now"
    p l Time.now, :full  #=> "3rd of January, 2010 18:54"
  end

end

inter = Internalization.new(ARGV[0])
inter.print_strings
inter.print_time
p Dir.pwd
p File.expand_path('~')