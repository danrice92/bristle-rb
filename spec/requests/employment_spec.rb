require "rails_helper"

describe "GET #index /employments" do
  it "responds with the user's employments" do
    get "/employments"

    expect(response.content_type).to eq("application/json; charset=utf-8")
    expect(response).to have_http_status(:ok)
    expect(response.body).to eq({"hi": "bye"}.to_json)
  end
end