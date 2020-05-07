module BreadcrumbHelper
  def breadcrumb
    content_tag :div, class: 'breadcrumb', "data-controller": 'breadcrumbs' do
      yield
    end
  end

  def breadcrumb_jump(name = nil, url = nil)
    if name && url
      content_tag :span, class: 'breadcrumb__item' do
        link_to(name, url, 'data-action': 'breadcrumbs#showJumpMenu')
      end
    end
  end

  def breadcrumb_item(name = nil, url = nil)
    if name && url
      content_tag :span, class: 'breadcrumb__item' do
        link_to(name, url, id: 'show_user_stations')
      end
    end
  end

  def breadcrumb_active_item(name = nil)
    if name
      content_tag :span, class: 'breadcrumb__item--current' do
        name
      end
    end
  end
end
