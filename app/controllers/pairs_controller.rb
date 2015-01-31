class PairsController < ApplicationController
  def index
    cohort = Cohort.find(params[:cohort_id])
    cohort.create_groups
    @groups = cohort.assign!
  end
end
