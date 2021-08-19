class EndangeredController < ApplicationController
  before_action :set_endangered, only: [:index, :data]
  
  def index
    return redirect_to engangered_data_path if @endangered < 0
    render 'index'
  end

  def data
  end

  def upload
    csv_file = File.join Rails.root, 'db', 'sharks.csv'
    AddEndangeredWorker.perform_async(csv_file)
    redirect_to engangered_data_path, notice: "Endangered sharks have been uploaded!"
  end

  def destroy
    RemoveEndangeredWorker.perform_async
    redirect_to root_path
  end

  private

  def set_endangered
    @endangered = Endangered.all
  end
end
