require "test_helper"

class AnsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @an = ans(:one)
  end

  test "should get index" do
    get ans_url
    assert_response :success
  end

  test "should get new" do
    get new_an_url
    assert_response :success
  end

  test "should create an" do
    assert_difference('An.count') do
      post ans_url, params: { an: {  } }
    end

    assert_redirected_to an_url(An.last)
  end

  test "should show an" do
    get an_url(@an)
    assert_response :success
  end

  test "should get edit" do
    get edit_an_url(@an)
    assert_response :success
  end

  test "should update an" do
    patch an_url(@an), params: { an: {  } }
    assert_redirected_to an_url(@an)
  end

  test "should destroy an" do
    assert_difference('An.count', -1) do
      delete an_url(@an)
    end

    assert_redirected_to ans_url
  end
end
