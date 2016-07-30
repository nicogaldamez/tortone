class PrinterController < ApplicationController

  def print_pdf
    filename = params[:filename] || 'impresion'
    pdf = SimplePdf.new(params[:body], view_context)
    send_data pdf.render, filename: filename,
              type: 'application/pdf',
              disposition: 'inline'
  end
end
