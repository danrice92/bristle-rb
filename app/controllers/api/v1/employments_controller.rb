module API::V1
  class EmploymentsController < APIController
    def index
      render json: {"hi": "bye"}
    end
  end
end