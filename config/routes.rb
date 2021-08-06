Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  namespace "api" do
    get "filings" => "filings#index"
    get "recipients" => "recipients#index"
  end
end
