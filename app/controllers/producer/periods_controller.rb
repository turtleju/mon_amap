# frozen_string_literal: true

class Producer::PeriodsController < Producer::BaseController
  def index
    @periods = policy_scope(Period)
  end
end
