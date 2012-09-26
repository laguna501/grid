module LoginAs
  def login_as(admin = FactoryGirl.create(:admin))
    user_session = UserSession.create(username: admin.username, password: admin.password)
    controller.instance_variable_set("@current_user_session", user_session)
    controller.instance_variable_set("@current_ability", Ability.new(admin))
    yield admin, user_session
  ensure
    user_session = controller.instance_variable_get("@current_user_session")
    user_session && user_session.destroy
    controller.instance_variable_set("@current_user_session", nil)
    controller.instance_variable_set("@current_ability", nil)
  end
end
