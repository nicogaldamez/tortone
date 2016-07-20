class AttachmentsController < ApplicationController

  include VehicleScoped

  def create
    @attachment = @vehicle.attachments.build(attachment_params)
    @attachment.save!
    respond_to do |format|
      format.js
    end
  end

  def destroy
    @attachment = Attachment.find(params[:id])
    @attachment.destroy!
  end

  private

  def attachment_params
    params.require(:attachment).permit(:file)
  end

end

