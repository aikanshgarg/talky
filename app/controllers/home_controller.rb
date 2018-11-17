class HomeController < ApplicationController
  
  # We’ll keep in a session array with conversation_ids which we opened. While we close a window, we’ll remove a conversation_id from the array.


  def index
  	session[:conversations] ||= []

  	# we select all users that are not us. They’ll be displayed on the chat list.
  	@users = User.all.where.not(id: current_user)

  	# we’re also including other models under the @conversations query to avoid N+1 queries.
  	@conversations = Conversation.includes(:recipient, :messages).find(session[:conversations])
  end

end
