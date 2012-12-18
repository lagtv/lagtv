class EmailController < ApplicationController
  before_filter { authorize! :create, Email }

  def new
    @email = Email.new
  end

  def create
    @email = Email.build(params[:email])
    if @email.valid?
      @email.deliver
    end
  end
end
