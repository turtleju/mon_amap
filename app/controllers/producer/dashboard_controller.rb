# frozen_string_literal: true

class Producer::DashboardController < Producer::BaseController
  def home
    authorize(Amap.current, :producer_management?)
  end
end
