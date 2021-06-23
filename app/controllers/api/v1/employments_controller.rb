module API::V1
  class EmploymentsController < APIController
    def index
      render json: {employments: Employment.all}
    end
  end
end