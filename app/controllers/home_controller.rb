class HomeController < ApplicationController
  def index
    @page_title = I18n.t 'home.title'
  end
end
