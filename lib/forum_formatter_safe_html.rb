require 'sanitize'

class ForumFormatterSafeHtml
  def self.format(content)
    matches = content.scan /:[a-zA-Z0-9_\-\+]+:/m
    matches.each do |emojis|
      content = content.gsub(emojis, "<img src=\"/assets/emojis/small/#{emojis_file(emojis)}.png\" align=\"middle\">")      
    end

    Sanitize.clean(content, 
      :elements => ['p', 'b', 'hr', 'font',  'img', 'ul', 'li', 'div', 'i', 'u', 'br', 'strike', 'span', 'blockquote'],
      :attributes => {'a' => ['href'], 'font' => ['size', 'color'], 'img' => ['src', 'alt', 'align'], 'div' => ['style'], 'b' => ['style'], 'strike' => ['style'], 'span' => ['style']},
      :protocols => {'a' => {'href' => ['http', 'https', 'mailto']}}
    ).html_safe
  end

  def self.sanitize(content)
    content
  end

  def self.blockquote(quote)
    "<blockquote>#{quote}</blockquote><br><br>".html_safe
  end

  def self.emojis_file(emojis)
    return "plus1" if emojis == ":+1:"

    emojis[1..-2]
  end
end