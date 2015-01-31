class WelcomeController < ApplicationController
  def index
    @cohorts = Cohort.all
  end
end
