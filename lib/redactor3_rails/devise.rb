module Redactor3Rails
  module Devise
    def redactor3_authenticate_user!
      authenticate_user!
    end

    def redactor3_current_user
      current_user
    end
  end
end
