class AnswerVotesController < ApplicationController
  before_action :logged_in
  def create
    @answer_vote = AnswerVote.new()
    @answer_vote.answer_id = params[:answer_id]
    @answer_vote.user_id = current_user.id
    @answer_vote.vector = params[:vector].to_f
    @answer_vote.save
    @answer = Answer.find(params[:answer_id])
    @answer.votes += params[:vector].to_f
    @answer.save
    @user = User.find(@answer.user_id)
    @user.rep += params[:vector].to_f
    @user.save
    respond_to do |format|
      if request.xhr?
        format.js {}
      else
        format.html { redirect_to field_question_path(id:Question.find(@answer.question_id).url, field_id: Field.find(Question.find(@answer.question_id).field_id).name) }
      end
    end
  end

  def edit
    @answer_vote = AnswerVote.find_by(answer_id:params[:answer_id], user_id:current_user.id)
    @answer = Answer.find(params[:answer_id])
    @answer.votes -= @answer_vote.vector.to_f
    @answer.votes += params[:vector].to_f
    @answer.save
    @user = User.find(@answer.user_id)
    @user.rep -= @answer_vote.vector
    @user.rep += params[:vector].to_f
    @user.save
    @answer_vote.vector = params[:vector].to_f
    @answer_vote.save
    respond_to do |format|
      if request.xhr?
        format.js {}
      else
        format.html { redirect_to field_question_path(id:Question.find(@answer.question_id).url, field_id: Field.find(Question.find(@answer.question_id).field_id).name) }
      end
    end
  end

  def destroy
    @answer_vote = AnswerVote.find_by(answer_id:params[:answer_id], user_id:current_user.id)
    @answer = Answer.find(params[:answer_id])
    @answer.votes -= @answer_vote.vector
    @answer.save
    @user = User.find(@answer.user_id)
    @user.rep -= @answer_vote.vector
    @user.save
    @answer_vote.destroy
    respond_to do |format|
      if request.xhr?
        format.js {}
      else
        format.html { redirect_to field_question_path(id:Question.find(@answer.question_id).url, field_id: Field.find(Question.find(@answer.question_id).field_id).name) }
      end
    end
  end

  def vote
    @exist = AnswerVote.find_by(user_id: current_user.id, answer_id: params[:answer_id])
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
