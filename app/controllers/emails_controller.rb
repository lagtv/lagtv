class EmailsController < ApplicationController
  before_filter { authorize! :create, Email }

  def new
    @email = Email.new
  end

  def create
    params[:email][:roles] = roles_to_str
    @email = Email.new(params[:email])
    if @email.save
      @email.deliver
      flash[:notice] = 'Your email is being processed and sent'
      render @email
    end
    render :new
  end

  private

  def roles_to_str
    params[:roles].select{|key, value| value.to_i == 1}.keys.join(' ')
  end

  def index
    @emails = Email.order('created_at desc')
  end
end
