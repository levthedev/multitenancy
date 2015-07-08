require_relative '../test_helper'

class AdminEditsStoreTest < ActionDispatch::IntegrationTest

  def setup
    Capybara.app = Storedom::Application
    reset_session!
  end

  def test_non_admin_cant_edit_a_store
    user = User.create(name: "Justin", email: "jdawg@gmail.com", password: "password")
    store = Store.create(name: "Pizza Palace")

    visit login_path

    fill_in "Email", with: "jdawg@gmail.com"
    fill_in "Password", with: "password"
    click_on "Enter Storedom"

    visit edit_store_path(store)
    assert_equal root_path, current_path
  end

end
