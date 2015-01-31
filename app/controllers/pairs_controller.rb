class PairsController < ApplicationController
  def index
    @groups = Cohort.find(params[:cohort_id]).assign!
  end
end
