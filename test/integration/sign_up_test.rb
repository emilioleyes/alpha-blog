require "test_helper"

class SignUpTest < ActionDispatch::IntegrationTest
  setup do
    @usuario = User.create(username: "eleyes", email: "eleyes@sam.com.ar",
                              password: "password")
  end

  test "registrarse correctamente" do
    get "/signup"
    assert_response :success
    assert_difference 'User.count', 1 do
      post users_path, params: { user: { username: "eleyes2", email: "eleyes@eleyes.com", password: "password" } }
      assert_response :redirect
    end
    follow_redirect!
    assert_response :success
    assert_match "eleyes2", response.body
  end

  test "registro incorrecto" do
    get "/signup"
    assert_response :success
    assert_no_difference 'User.count' do
      post users_path, params: { user: { username: " ", email: " ", password: "password" } }
    end
  end
end
