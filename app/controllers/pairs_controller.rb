class PairsController < ApplicationController

  def new
    @pair = Pair.new
  end

  def create
    @pair = Pair.new

    if @pair.save
      redirect_to pairs_path
    else
      redirect_to students_path
    end
  end

  def index
    @pairs = Pair.find(updated_at: Time.now.to_time - 1)
  end

end
