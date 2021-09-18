require "application_system_test_case"

class AnsTest < ApplicationSystemTestCase
  setup do
    @an = ans(:one)
  end

  test "visiting the index" do
    visit ans_url
    assert_selector "h1", text: "Ans"
  end

  test "creating a An" do
    visit ans_url
    click_on "New An"

    click_on "Create An"

    assert_text "An was successfully created"
    click_on "Back"
  end

  test "updating a An" do
    visit ans_url
    click_on "Edit", match: :first

    click_on "Update An"

    assert_text "An was successfully updated"
    click_on "Back"
  end

  test "destroying a An" do
    visit ans_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "An was successfully destroyed"
  end
end
