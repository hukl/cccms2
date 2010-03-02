# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key    => '_cccms2_session',
  :secret => '1c0288c85fa3da2f213717cfa359608eaab9f0d043b2e5b8e6345e0449ace8fbeca3b9427b4034d1e28b34e905a0d617ccb2e9cb362b55e15411f58879e7349d'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
