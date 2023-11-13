class HomeController < ApplicationController
  def index
    @all_guesthouses = Guesthouse.where(status: true).order(created_at: :desc)
    @recent_guesthouses = @all_guesthouses.limit(3)
    @other_guesthouses = @all_guesthouses.where.not(id: @recent_guesthouses.pluck(:id))
  end
end
