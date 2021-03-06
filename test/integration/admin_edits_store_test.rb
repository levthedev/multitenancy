require_relative '../test_helper'

class AdminEditsStoreTest < ActionDispatch::IntegrationTest

  def setup
    Capybara.app = Storedom::Application
    reset_session!
  end

  def test_non_admin_cant_edit_a_store
    user = User.create(name: "Justin",
                       email: "jdawg@gmail.com",
                       password: "password")

    admin_role = Role.create(name: "admin")

    store = Store.create(name: "Pizza Palace")

    visit login_path

    fill_in "Email", with: "jdawg@gmail.com"
    fill_in "Password", with: "password"
    click_on "Enter Storedom"

    visit edit_store_path(store)
    assert_equal root_path, current_path
  end

  def test_admin_can_edit_stores
    admin = User.create(name: "Justin",
                       email: "jdawg@gmail.com",
                       password: "password")

    store = Store.create(name: "Pizza Palace")

    visit login_path

    admin_role = Role.create(name: "admin")

    admin.user_roles.create(role: admin_role,
                            store: store)

    fill_in "Email", with: "jdawg@gmail.com"
    fill_in "Password", with: "password"
    click_on "Enter Storedom"

    visit edit_store_path(store)
    assert_equal edit_store_path(store), current_path
  end

end
