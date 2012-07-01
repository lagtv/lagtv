require 'redcarpet'

class ForumFormatterMarkdown
  def self.format(content)
    markdown = Redcarpet::Markdown.new(Redcarpet::Render::HTML, :autolink => true)
    markdown.render(content).html_safe
  end
end