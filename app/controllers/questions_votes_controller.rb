class QuestionsVotesController < ApplicationController
  before_action :logged_in
  def create
    @question_vote = QuestionVote.new()
    @question_vote.question_id = params[:question_id]
    @question_vote.user_id = current_user.id
    @question_vote.vector = params[:vector].to_f
    @question_vote.save
    @question = Question.find(params[:question_id])
    @question.votes += params[:vector].to_f
    @question.save
    @user = User.find(@question.user_id)
    @user.rep += params[:vector].to_f
    @user.save
    respond_to do |format|
      if request.xhr?
        format.js {}
      else
        format.html { redirect_to field_question_path(id:@question.url, field_id: Field.find(@question.field_id).name) }
      end
    end
  end

  def edit
    @question_vote = QuestionVote.find_by(question_id:params[:question_id], user_id:current_user.id)
    @question = Question.find(params[:question_id])
    @question.votes -= @question_vote.vector.to_f
    @question.votes += params[:vector].to_f
    @question.save
    @user = User.find(@question.user_id)
    @user.rep -= @question_vote.vector
    @user.rep += params[:vector].to_f
    @user.save
    @question_vote.vector = params[:vector].to_f
    @question_vote.save
    respond_to do |format|
      if request.xhr?
        format.js {}
      else
        format.html {redirect_to field_question_path(id:@question.url, field_id: Field.find(@question.field_id).name)}
      end
    end
  end

  def destroy
    @question_vote = QuestionVote.find_by(question_id:params[:question_id], user_id:current_user.id)
    @question = Question.find(params[:question_id])
    @question.votes -= @question_vote.vector
    @question.save
    @user = User.find(@question.user_id)
    @user.rep -= @question_vote.vector
    @user.save
    @question_vote.destroy
    respond_to do |format|
      if request.xhr?
        format.js {}
      else
        format.html {redirect_to field_question_path(id:@question.url, field_id: Field.find(@question.field_id).name)}
      end
    end
  end

  def vote
    @exist = QuestionVote.find_by(user_id: current_user.id, question_id: params[:question_id])
    if (params[:vector]== 1.to_s or params[:vector]== -1.to_s)
      if @exist.nil?
        create
      elsif (@exist.vector == params[:vector].to_f )
        destroy
      elsif (@exist.vector != params[:vector].to_f )
        edit
      end
    end
  end
end
