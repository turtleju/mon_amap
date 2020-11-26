# frozen_string_literal: true

class ProducersController < ApplicationController
  def invitation
    @producer = Producer.new
    authorize(@producer)
  end

  def invite
    @producer = Producer.find_by(email: params[:producer][:email])
    if @producer
      authorize(@producer)
      puts 'send email...'
      # TODO: envoyer un email
    else
      @producer = Producer.new(email: params[:producer][:email])
      authorize(@producer)
      @producer.save!
    end
    AmapProducer.create!(producer: @producer)
    redirect_to root_path
  end
end
