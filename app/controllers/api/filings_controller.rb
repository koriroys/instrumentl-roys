module Api
  class FilingsController < ApplicationController
    def index
      render json: FilingSerializer.new(Filing.all, {include: [:'filer.name', :'awards.amount', :'awards.purpose']}).serializable_hash
    end
  end
end