class HomeController < ApplicationController
  def index
    render plain: 'Fullstack Challenge 20201026', status: :ok
  end
end
