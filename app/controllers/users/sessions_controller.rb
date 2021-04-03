class Users::SessionsController < Devise::SessionsController
  def new
    super
  end

  def create
    super do |resource|
      BackgroundWorker.trigger(resource)
    end
  end
end
