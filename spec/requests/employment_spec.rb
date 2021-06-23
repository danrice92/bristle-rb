require "rails_helper"

describe "GET #index /employments" do
  let(:user) { create :user }
  let!(:employment) { create :employment, user: user }
  let!(:second_employment) { create :employment, user: user }

  it "responds with the user's employments" do
    get "/api/v1/employments"

    expect(response.content_type).to eq("application/json; charset=utf-8")
    expect(response).to have_http_status(:ok)
    expect(response.body).to eq({employments: [employment, second_employment]}.to_json)
  end
end