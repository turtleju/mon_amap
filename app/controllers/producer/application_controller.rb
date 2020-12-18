# frozen_string_literal: true

class Producer::ApplicationController < ApplicationController
  skip_before_action :authenticate_user!
  before_action :authenticate_producer!
end
