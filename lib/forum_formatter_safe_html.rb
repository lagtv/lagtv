require 'sanitize'

class ForumFormatterSafeHtml
  def self.format(content)
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
end