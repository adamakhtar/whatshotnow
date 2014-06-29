module Features
  
  module SignInHelpers
    def sign_in(user)
      login_as(user)
    end

    def sign_out
      logout
    end
  end
end
