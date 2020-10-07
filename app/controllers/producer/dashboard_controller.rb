# frozen_string_literal: true

class Producer::DashboardController < Producer::BaseController
  def home
    authorize(@amap, :producer_management?)
  end
end
