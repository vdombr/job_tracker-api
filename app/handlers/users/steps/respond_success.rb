module Handlers
  module Users
    module Steps
      class RespondSuccess < Rivulet::Step
        def call(input)
          current_user, token, action = input[:context].values_at(:current_user, :token, :action)

          status = action == :create ? 201 : 200
          body = { data: current_user, meta: { token: token } }

          Success(Rivulet::Response.new(body: body, status: status))
        end
      end
    end
  end
end
