# frozen_string_literal: true

class Manager::SubscriptionsController < Manager::ApplicationController
  def index
    ap "je suis dans #{__method__}"
    ap request.subdomains
    ap request.fullpath
    ap request.methods.grep(/path/)
    @subscriptions = Subscription.with_payment
  end
end
