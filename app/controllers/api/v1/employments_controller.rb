module API::V1
  class EmploymentsController < APIController
    def index
      employments = Employment.all.includes(:user, :user_career, :employer).map do |employment|
        {
          job_title: employment.title,
          employer_name: employment.employer.name,
          start_date: employment.start_date,
          end_date: employment.end_date,
          starting_pay: employment.starting_pay,
          ending_pay: employment.ending_pay,
          career_title: employment.career.title,
          location: employment.location
        }
      end
      render json: {employments: employments}
    end
  end
end