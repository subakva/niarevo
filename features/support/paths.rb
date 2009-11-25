module NavigationHelpers
  # Maps a name to a path. Used by the
  #
  #   When /^I go to (.+)$/ do |page_name|
  #
  # step definition in webrat_steps.rb
  #
  def path_to(page_name)
    case page_name
    
    when /the home\s?page/
      '/'
    when /the new account page/
      new_account_path
    when /the failed new account page/
      account_path
    when /the account page/
      account_path
    when /the edit account page/
      edit_account_path
    when /the failed edit account page/
      account_path
    when /the login page/
      new_user_session_path
    when /the failed login page/
      user_session_path
    when /the activation index page/
      activations_path
    when /the activation page/
      new_activation_path
    when /the wrong activation page/
      edit_activation_path('not-the-real-token')
    when /my activation page/
      @current_user.reload
      edit_activation_path(@current_user.perishable_token)
    when /the password reset page/
      new_password_reset_path
    when /the wrong password reset page/
      edit_password_reset_path('not-the-real-token')
    when /my password reset page/
      @current_user.reload
      edit_password_reset_path(@current_user.perishable_token)
    when /the dreams page$/
      dreams_path
    when /the dreams page for the user "([^\"]*)"/
      user_dreams_path($1)
    when /the dreams page for the dream tag "([^\"]*)"/
      dream_tag_dreams_path($1)
    when /the dreams page for the context tag "([^\"]*)"/
      context_tag_dreams_path($1)
    when /the dreams page for the tag "([^\"]*)"/
      tag_dreams_path($1)
    when /the dreams page for ([0-9]*)$/
      dreams_by_year_path(:year => $1)
    when /the dreams page for ([0-9]*)\/([0-9]*)$/
      dreams_by_month_path(:year => $2, :month => $1)
    when /the dreams page for ([0-9]*)\/([0-9]*)\/([0-9]*)/
      dreams_by_day_path(:year => $3, :month => $1, :day => $2)
    when /the new dream page/
      new_dream_path
    when /the new dream error page/
      dreams_path
    when /the newest dream page/
      dream_path(Dream.last)
    when /the dream details page for my dream/
      dream_path(@current_dream)
    when /the edit dream page for my dream/
      edit_dream_path(@current_dream)
    when /the edit dream error page for my dream/
      dream_path(@current_dream)

    # Add more mappings here.
    # Here is a more fancy example:
    #
    #   when /^(.*)'s profile page$/i
    #     user_profile_path(User.find_by_login($1))

    else
      raise "Can't find mapping from \"#{page_name}\" to a path.\n" +
        "Now, go and add a mapping in #{__FILE__}"
    end
  end
end

World(NavigationHelpers)
