# frozen_string_literal: true

class ApplicationPolicy
  attr_reader :user, :producer, :record, :amap

  def initialize(context, record)
    @user     = context[:user]
    @producer = context[:producer]
    @record   = record
    @amap     = Amap.current
  end

  def index?
    false
  end

  def show?
    false
  end

  def create?
    false
  end

  def new?
    create?
  end

  def update?
    false
  end

  def edit?
    update?
  end

  def destroy?
    false
  end

  class Scope
    attr_reader :user, :producer, :scope, :amap

    def initialize(context, scope)
      @user     = context[:user]
      @producer = context[:producer]
      @amap     = Amap.current

      @scope = scope
    end

    def resolve
      scope.all
    end
  end

  private

  def manager?
    amap && amap.manager == user
  end
end
