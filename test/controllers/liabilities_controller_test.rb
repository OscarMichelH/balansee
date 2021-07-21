require "test_helper"

class LiabilitiesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @liability = liabilities(:one)
  end

  test "should get index" do
    get liabilities_url
    assert_response :success
  end

  test "should get new" do
    get new_liability_url
    assert_response :success
  end

  test "should create liability" do
    assert_difference('Liability.count') do
      post liabilities_url, params: { liability: { debt: @liability.debt, departure_date: @liability.departure_date, description: @liability.description, name: @liability.name, payment: @liability.payment, user_id: @liability.user_id } }
    end

    assert_redirected_to liability_url(Liability.last)
  end

  test "should show liability" do
    get liability_url(@liability)
    assert_response :success
  end

  test "should get edit" do
    get edit_liability_url(@liability)
    assert_response :success
  end

  test "should update liability" do
    patch liability_url(@liability), params: { liability: { debt: @liability.debt, departure_date: @liability.departure_date, description: @liability.description, name: @liability.name, payment: @liability.payment, user_id: @liability.user_id } }
    assert_redirected_to liability_url(@liability)
  end

  test "should destroy liability" do
    assert_difference('Liability.count', -1) do
      delete liability_url(@liability)
    end

    assert_redirected_to liabilities_url
  end
end
