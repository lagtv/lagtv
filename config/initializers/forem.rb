Forem.user_class = "User"
Forem.email_from_address = "\"LAGTV Forum\" <no-reply@lag.tv>"
Forem.per_page = 20
Forem.sign_in_path = "/login"
Forem.formatter = ForumFormatterSafeHtml

Rails.application.config.to_prepare do
  Forem::Ability.register_ability(Ability)
end