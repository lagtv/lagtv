class EmailsController < ApplicationController
  before_filter { authorize! :create, Email }

  def new
    @email = Email.new
  end

  def create
    params[:email][:roles] = roles_to_str
    @email = Email.new(params[:email])
    if @email.valid? && @email.save
      @email.deliver
      flash[:notice] = 'Email is being processed.'
    end
    render :new
  end

  private

  def roles_to_str
    params[:roles].select{|key, value| value.to_i == 1}.keys.join(' ')
  end
end
