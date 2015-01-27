require 'test_helper'

class UsersEditTest < ActionDispatch::IntegrationTest

	def setup
		@user = users(:curtis)
	end

	test "unsuccessful edit" do 
		log_in_as(@user)
		get edit_user_path(@user)
		assert_template 'users/edit'
		patch user_path(@user), user: { name: "",
		                                email: "tyrantt@invalid",
		                                password:                  "halo",
		                                password_confirmation:     "rocks" }
		assert_template 'users/edit'
	end

	test "successful edit with friendly forwarding" do 
		get edit_user_path(@user)
		log_in_as(@user)
		assert_redirected_to edit_user_path(@user)
		name  = "Curtis Lawson"
		email = "tyrantt47@hotmail.com"
		patch user_path(@user), user: { name:   name, 
										email:  email,
									    password:              "halorocks", 
									    password_confirmation: "halorocks" }
		assert_not flash.empty?
		assert_redirected_to @user 
		@user.reload
		assert_equal @user.name,  name
		assert_equal @user.email, email
	end
end


