module API::V1
  class APIController < ApplicationController
    def current_user
      User.find(1)
    end
  end
end
