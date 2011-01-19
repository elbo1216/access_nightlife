# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_tmp_session',
  :secret      => '2b58f5e1f7c2b84f313195d0d9df4123845270267de137cf06a4e9c4aebe3f7a0084729cb499681456ccd525eadeabc7f8dd157f994ade530a9ecaed8527a97a'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
