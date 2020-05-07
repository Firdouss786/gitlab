# :nocov:
class ChangelogsController < ApplicationController
  def index
  	markdown = Redcarpet::Markdown.new(Redcarpet::Render::HTML, autolink: true, tables: true)

  	data = File.read("CHANGELOG.md")

  	@changelog = markdown.render(data).html_safe
  end
end
# :nocov:
