class CohortsController < ApplicationController

  def index
    @cohorts = Cohort.all
  end

  def show
    @cohort = Cohort.find(name: params[name])
  end

end
