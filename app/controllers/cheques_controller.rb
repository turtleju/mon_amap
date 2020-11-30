# frozen_string_literal: true

class ChequesController < ApplicationController
  def index
    @cheques = policy_scope(Cheque)
  end

  def deposit
    authorize(Cheque)
    policy_scope(Cheque).update_all(status: :deposited)
    redirect_back(fallback_location: cheques_path, notice: t('.success'))
  end
end
