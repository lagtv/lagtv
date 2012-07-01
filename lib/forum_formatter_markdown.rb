class ForumFormatterMarkdown
  def self.format(content)
    #Markdown.new(content).to_html.html_safe

    markdown = Redcarpet::Markdown.new(Redcarpet::Render::HTML, :autolink => true)
    markdown.render(content).html_safe
  end
end