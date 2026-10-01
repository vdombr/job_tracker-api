module Services
  module Users
    module Projections
      class Common < Rivulet::Projection
        define! do
          accept_keys(%i[id name email])
        end
      end
    end
  end
end
