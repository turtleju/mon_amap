# frozen_string_literal: true

class Manager::ApplicationController < ApplicationController
  skip_after_action :verify_authorized
  skip_after_action :verify_policy_scoped
end
