def sign_in_user
  @mail = "shahaf@ftbpro.com"
  cookies[:mail] = @mail
  u = User.create mail: @mail
  u
end

def sign_out_user
  cookies[:mail] = nil
end
