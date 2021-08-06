module Api
  class RecipientsController < ApplicationController
    def index
      recipient_ids = Award.pluck(:recipient_id).uniq

      result = if params[:state]
        orgs = Organization.joins(:addresses).where(id: recipient_ids).where("addresses.state = ?", params[:state]).uniq
        RecipientSerializer.new(orgs, {include: [:addresses]}).serializable_hash
      else
        RecipientSerializer.new(Organization.where(id: recipient_ids), {include: [:addresses]}).serializable_hash
      end
      render json: result
    end
  end
end