require "test_helper"

class CreateCategoryTest < ActionDispatch::IntegrationTest
  setup do
    @admin_user = User.create(username: "eleyes", email: "eleyes@sam.com.ar",
                              password: "password", admin: true)
    sign_in_as(@admin_user)
  end

  test "obtener el nuevo formulario de categoría y crear categoría" do
    get "/categories/new"
    assert_response :success
    assert_difference 'Category.count', 1 do
      post categories_path, params: { category: { name: "Sports"} }
      assert_response :redirect
    end
    follow_redirect!
    assert_response :success
    assert_match "Sports", response.body
  end



  test "obtener nuevo formulario de categoría y rechazar creación invalida" do
    get "/categories/new"
    assert_response :success
    assert_no_difference 'Category.count' do
      post categories_path, params: { category: { name: " "} }
    end
    assert_match "errores", response.body
    assert_select 'div.alert'
    assert_select 'h4.alert-heading'
  end

end
