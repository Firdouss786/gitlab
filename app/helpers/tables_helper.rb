module TablesHelper

  def sortable(column, title = nil)
    title ||= column.titleize.upcase
    direction = column == sort_column && sort_direction == "asc" ? "desc" : "asc"
    icon = column == sort_column ? get_icon(direction) : nil
    link_to "#{title} &nbsp;#{icon}".html_safe, request.query_parameters.merge({ sort: column, direction: direction, page: nil, refresh: nil })
  end

  def get_icon(direction)
    direction == 'asc' ? fa_icon('angle-up') : fa_icon('angle-down')
  end

end
