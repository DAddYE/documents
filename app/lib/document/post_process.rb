module DocumentPostProcess

  def search(*args)
    nokogiri.search(*args)
  end

  def at(*args)
    nokogiri.at(*args)
  end

  def sections
    search('body > h2').map(&:text)
  end

  private
  def nokogiri
    @_nokogiri = Nokogiri::HTML(html)
  end
end
