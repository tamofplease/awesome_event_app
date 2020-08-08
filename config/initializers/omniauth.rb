Rails.application.config.middleware.use OmniAuth::Builder do
  if Rails.env.development? || Rails.env.test?
    provider :github, "9904f2fdfc1ff8742f92", "d660b1662778538b0ed7f6c3b84af943cbb17f5d"
  else
    provider :github,
      Rails.application.credentials.github[:client_id],
      Rails.applicaton.creadentials.github[:client_secret]
  end
end
