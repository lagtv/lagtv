require 'redcarpet/compat'

class ForumFormatterMarkdown
  def self.format(content)
    Markdown.new(content).to_html.html_safe
  end
end