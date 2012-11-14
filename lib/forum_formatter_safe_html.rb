require 'sanitize'

class ForumFormatterSafeHtml
  def self.format(content)
    # matches = content.scan /:[a-zA-Z0-9_\-\+]+:/m
    # matches.each do |emojis|
    #   filename = "#{emojis_file(emojis)}.png"
    #   file_path = "#{Rails.root}/app/assets/images/emojis/small/#{filename}"
    #   content = content.gsub(emojis, "<img src=\"/assets/emojis/small/#{filename}\" align=\"middle\">") if File.exists? file_path
    # end

    Sanitize.clean(content, 
      :elements => ['a', 'p', 'b', 'hr', 'font',  'img', 'ul', 'li', 'div', 'i', 'u', 'br', 'strike', 'span', 'blockquote', 'h1', 'h2', 'h3', 'h4'],
      :attributes => {'a' => ['href', 'target', 'title'], 'font' => ['size', 'color'], 'img' => ['src', 'alt', 'align'], 'div' => ['style'], 'b' => ['style'], 'strike' => ['style'], 'span' => ['style']},
      :protocols => {'a' => {'href' => ['http', 'https', 'mailto']}}
    ).html_safe
  end

  def self.sanitize(content)
    content
  end

  def self.blockquote(quote)
    "<blockquote>#{quote}</blockquote><br><br>".html_safe
  end

  # def self.emojis_file(emojis)
  #   return "plus1" if emojis == ":+1:"
  #   emojis[1..-2]
  # end
end