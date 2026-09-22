module Services
  module Users
    module Projections
      class Common < Rivulet::Projection
        define! do
          accept_keys(%i[name email])
        end
      end
    end
  end
end
