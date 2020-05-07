class ApidocsController < ApplicationController
  def index
    markdown = Redcarpet::Markdown.new(Redcarpet::Render::HTML, autolink: true, tables: true, quote: true, no_intra_emphasis: true, disable_intended_code_blocks: true, fenced_code_blocks: true, strikethrough: true, superscript: true, lax_spacing: true)
    api_data = File.read("docs/api/README.md")

    render_doc = api_data.gsub("https://github.com/thalesinflyt/", "/apidocs/")
    render_docs = render_doc.gsub("./sections/", "/apidocs/")

    @api_docs = markdown.render(render_docs).html_safe
  end

  def show
    @api_name = params[:id]
    anchor_links = Redcarpet::Render::HTML.new(with_toc_data:true)
    markdown = Redcarpet::Markdown.new(anchor_links, autolink: true, tables: true, quote: true, no_intra_emphasis: true, disable_indented_code_blocks: true, fenced_code_blocks: true, strikethrough: true, superscript: true, lax_spacing: true)
    render_doc = File.read("docs/api/sections/#{@api_name}.md")
    @api_endpoint_docs = markdown.render(render_doc).html_safe
  end
  
end
