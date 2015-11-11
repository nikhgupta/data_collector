module IntegrationHelpers
  def stub_env_var(name, value)
    allow(ENV).to receive(:[]).and_call_original
    allow(ENV).to receive(:[]).with(name.to_s.upcase).and_return value.to_s
  end

  def show_page
    save_page Rails.root.join('public', 'capybara.html')
    %x(launchy http://#{ENV['BASE_URL']}/capybara.html)
  end

  def login_as(user, password = "password")
    visit destroy_user_session_path
    visit new_user_session_path
    fill_in "Email", with: user.email
    fill_in "Password", with: password
    click_on "Log in"
    user
  end

  def login
    login_as @user
  end

  def json
    return nil if response.blank? || !response.respond_to?(:body)
    JSON.parse response.body rescue nil
  end
end
