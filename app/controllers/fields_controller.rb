class FieldsController < ApplicationController
  before_action :admin_only, only: [:new, :destroy, :create]

  def new
      @field = Field.new
  end

  def create
    @field = Field.new(field_params)
    @field.save()
    flash[:message] = "Field created!"
    redirect_to root_url
  end

  def show
    @field = Field.find_by(name:params[:id])
  end

  def index
    @fields = Field.all
  end

  def destroy

  end

  def questions
    @field = Field.find_by(:name => params[:field_id])
    @questions = Question.where(:field_id => @field.id)
  end

  def new_moderator

  end

  private
  def field_params
    params.require(:field).permit(:name)
  end

  def admin_only
    if current_user.admin==false
      flash[:danger]="Not Authorized!"
      redirect_to user_path(current_user)
    end
  end
end
