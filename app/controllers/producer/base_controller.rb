# frozen_string_literal: true

class Producer::BaseController < ApplicationController
  skip_before_action :authenticate_user!
  before_action :authenticate_producer!
end
