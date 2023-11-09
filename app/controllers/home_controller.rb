class HomeController < ApplicationController
  def index
    @guesthouses = if user_signed_in?
                     Guesthouse.all
                   else
                     Guesthouse.where(status: true)
                   end
  end
end