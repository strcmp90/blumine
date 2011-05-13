class PagesController < ApplicationController
  before_filter :must_login_first, :only => :stats

  def index
    if current_user 
      @title = t(:dashboard)
      @user = current_user
      render 'dashboard'
    else
      @title = t(:home)
      @user_session = UserSession.new
      render 'user_sessions/new', :layout => 'focus'
    end
  end

  def stats
    breadcrumbs.add t(:stats)
    @users_working_on = {}
    Issue.only_working_on.each do |issue|
      user = issue.assigned_user
      if @users_working_on[user]
        @users_working_on[user] << issue
      else
        @users_working_on[user] = [issue]
      end
    end
  end
end
