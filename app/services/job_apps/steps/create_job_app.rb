module Services
  module JobApps
    module Steps
      class CreateJobApp < Rivulet::Step
        def call(input)
          input => { resource:, attributes: }

          create_params = attributes.merge(
            user_id: input[:current_user],
            current_stage: JobApp::INIT_STAGE
          )

          input[:resource] = resource.create(create_params)

          Success(input)
        end
      end
    end
  end
end
