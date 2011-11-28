class PortfolioController < ApplicationController
def index
    @projects = Project.all
  end
end
