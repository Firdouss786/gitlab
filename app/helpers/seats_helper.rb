module SeatsHelper
  def to_css_grid(columns)
    final_string = ""
    columns.each {|col| final_string << "\[#{col.downcase}\] 30px "}
    final_string.strip
  end
end
