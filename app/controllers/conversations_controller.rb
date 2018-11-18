class ConversationsController < ApplicationController
  
  # In this method, we just get a conversation between a current user and requested user. If in the session there is no added conversation_id yet, we’ll add it, if not, we’ll just respond with a js file.
  def create
    @conversation = Conversation.get(current_user.id, params[:user_id])
    
    add_to_conversations unless conversated?

    respond_to do |format|
      format.js
    end
  end

  private

  # An array which stores all the conversation ids
  def add_to_conversations
    session[:conversations] ||= []
    session[:conversations] << @conversation.id
  end

  # check if id is present is array 
  def conversated?
    session[:conversations].include?(@conversation.id)
  end
end