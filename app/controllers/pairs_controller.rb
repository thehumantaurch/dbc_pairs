class PairsController < ApplicationController
  def show
    @groups = Cohort.find(params[:cohort_name]).assign!
  end
end
