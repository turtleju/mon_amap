# frozen_string_literal: true

class Producer::ChequesController < Producer::ApplicationController
  def index
    @cheques = policy_scope(Cheque).order(:cashing_on)
  end
end
