class ToPdf < Prawn::Document

  def initialize(view, page_layout = :portrait, page_size = 'A4')
    super(:page_layout => page_layout, page_size: page_size)
    @view = view
    font 'Helvetica', size: 10
  end

  # ----------------------------------------------------------------------------------------
  # TYPOGRAPHY
  # ----------------------------------------------------------------------------------------
  def h1(text, *args)
    options = args.extract_options!
    options[:align] ||= :center

    text text, size: 30, style: :bold, align: options[:align]
    move_down 10
  end

  def h2(text, *args)
    options = args.extract_options!
    options[:align] ||= :center

    text text, size: 25, style: :bold, align: options[:align]
    move_down 10
  end

  def h3(text, *args)
    options = args.extract_options!
    options[:align] ||= :center

    text text, size: 20, style: :bold, align: options[:align]
    move_down 10
  end

  def h4(text, *args)
    options = args.extract_options!
    options[:align] ||= :center

    text text, size: 16, style: :bold, align: options[:align]
    move_down 10
  end

  def h5(text, *args)
    options = args.extract_options!
    options[:align] ||= :center

    text text, size: 14, style: :bold, align: options[:align]
    move_down 10
  end

  def p(text, *args)
    options = args.extract_options!
    options[:align] ||= :left
    options[:style] ||= :normal
    options[:size] ||= 11
    text text, size: options[:size], style: options[:style], align: options[:align],
      inline_format: true
  end

  def field(label, content)
    text "<b>#{label}: </b> #{content.presence || '--' }", inline_format: true
    move_down 5
  end

  # ----------------------------------------------------------------------------------------
  # TABLE
  # ----------------------------------------------------------------------------------------
  def display_table(data, colors=[])
    table(data, cell_style: { borders: [], padding: 0 }, width: 520, header: true, row_colors: colors ) do |table|
      table.row(0).font_style = :bold
      table.row(0..data.count).padding    = 4
      table.row(0).borders    = [:top, :bottom]
      table.row(0).padding    = 4
    end
    move_down 10
  end

  # ----------------------------------------------------------------------------------------
  # MISC
  # ----------------------------------------------------------------------------------------

  def to_currency(a_value)
    @view.number_to_currency(a_value)
  end

  def display_separator
    move_down 10
    stroke_horizontal_rule
    move_down 10
  end

  def img(url, *args)
    options = args.extract_options!
    left   = options[:left] || 0
    top    = options[:top] || 0
    size   = options [:size] || 200
    image url, :at => [left, top], :width => size
  end

  def landscape_logo(url)
    image url, :at => [100,745], :width => 400
  end

  def uploaded_file_path(url)
    File.join(Rails.root, 'public', url)
  end

  def image_path(name)
    File.join(Rails.root, 'app', 'assets', 'images', name)
  end

end

