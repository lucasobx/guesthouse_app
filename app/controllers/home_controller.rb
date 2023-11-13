class HomeController < ApplicationController
  def index
    return @guesthouses = owner_guesthouses if user_signed_in? && current_user.owner? 
    @guesthouses = visitor_guesthouses
  end

  def owner_guesthouses
    Guesthouse.where(status: true).or(Guesthouse.where(user: current_user))
  end

  def visitor_guesthouses
    Guesthouse.where(status: true)
  end
end