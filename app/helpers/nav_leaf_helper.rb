module NavLeafHelper
  def leaf_active_if(str)
    "nav__leaf #{'nav__leaf--active' if request.path.include?(str)}"
  end
end
