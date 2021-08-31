require "rails_helper"

describe "/employments" do
  context "GET #index" do
    let(:user) { create :user }
    let!(:employment) { create :employment, user: user }
    let!(:second_employment) { create :employment, user: user }

    it "responds with the user's employments" do
      get "/api/v1/employments"

      expect(response.content_type).to eq("application/json; charset=utf-8")
      expect(response).to have_http_status(:ok)
      expect(response.body).to eq({employments: [
        { 
          job_title: employment.title,
          employer_name: employment.employer_name,
          start_date: employment.start_date,
          end_date: employment.end_date,
          starting_pay: employment.starting_pay,
          ending_pay: employment.ending_pay,
          career_title: employment.career.title,
          location: employment.primary_location
        },
        {
          job_title: second_employment.title,
          employer_name: second_employment.employer_name,
          start_date: second_employment.start_date,
          end_date: second_employment.end_date,
          starting_pay: second_employment.starting_pay,
          ending_pay: second_employment.ending_pay,
          career_title: second_employment.career.title,
          location: second_employment.primary_location
        }
      ]}.to_json)
    end
  end
end