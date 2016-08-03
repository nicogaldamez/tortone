class SimplePdf < ToPdf

  def initialize(body, view)
    super view, :portrait, 'A4'
    @view = view
    @body = body

    display_header
    display_body
  end

  def display_header
    bounding_box([100, cursor], width: 290) do
      image image_path('logo.jpg'), :width => 150
    end
  end

  def display_body
    move_down 30
    text sanitize(@body), inline_format: true
  end

  def sanitize(str)
    str.gsub! '<div>', ''
    str.gsub! '</div>', '<br> '
    str.gsub! '&nbsp;', NBSP
    str
  end

end

