# frozen_string_literal: true

class Manager::SubscriptionsController < Manager::ApplicationController
  def index
    @subscriptions = Subscription.with_payment
  end
end
