class BudgetPdf < ToPdf

  def initialize(budget, view)
    super view, :portrait, 'A5'
    @budget = budget.decorate
    @view = view

    display_header
    display_data
    display_footer
  end

  def display_header
    bounding_box([100, cursor], width: 290) do
      image image_path('logo.jpg'), :width => 150
    end
  end

  def display_data
    move_down 30
    p @budget.budgeted_on.to_s , align: :right
    move_down 20

    p "<b>Vehículo:</b> #{@budget.vehicle_description} "\
      '                                          '\
      "<b>Año:</b>  #{@budget.year}"
    move_down 20

    p "<b>Precio:</b> #{to_currency @budget.price} "\
      '                              '\
      "<b>Anticipo:</b>  #{to_currency @budget.minimum_advance}"
    move_down 20

    p "<b>A Financiar::</b> #{to_currency @budget.financed} "\
      '             '\
      "<b>Cuotas:</b>  #{@budget.installments}"\
      '             '\
      "<b>Valor:</b>  #{to_currency @budget.installments_cost}"
    move_down 20

    p "<b>Gastos:</b> #{to_currency(@budget.expenses)}"
    move_down 20

    p '<b>Descripción</b>'
    move_down 10
    p @budget.notes
  end

  def display_footer
    move_down 50
    display_separator
    move_down 10
    c = cursor
    bounding_box([0, c], width: 290) do
      p 'tortoneautomotores@gmail.com', size: 9
      move_down 5
      p 'Cel.: 221 642 6049', size: 9
      move_down 5
      p 'NexTel: 593*126', size: 9
      move_down 5
      p 'Calle Nro 566. La Plata', size: 9
    end
    bounding_box([235, c], width: 113) do
      p 'Matias Tortone', size: 17
      move_down 5
      p 'Asesor Comercial', size: 11, align: :right
    end

  end


end

