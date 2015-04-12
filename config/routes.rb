# -*- encoding : utf-8 -*-
Rails.application.routes.draw do
  if Rubykassa::Client.configuration
    scope '/payment' do
      %w(paid success fail).map do |route|
        method(Rubykassa.http_method).call "/#{route}" => "payments##{route}", as: "robokassa_#{route}" 
      end
    end
  end
end
