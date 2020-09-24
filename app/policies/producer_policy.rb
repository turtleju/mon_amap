# frozen_string_literal: true

class ProducerPolicy < ApplicationPolicy
  def invitation?
    invite?
  end

  def invite?
    user == amap.manager
  end

  class Scope < Scope
    def resolve
      scope.all
    end
  end
end
