# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_niarevo_session',
  :secret      => 'caaab6ce81104398272f53131aa18294d20c766a4338353762f6db89ede834fdb03300cb3a25c39da61c09a02d096e3b96bb1798eab35b35fb88c4340bc76d06'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
