Factory.sequence :login do |n|
  "knocker#{n}"
end

Factory.define :user do |u|
  u.login { Factory.next :login }
  u.email { |u| "#{u.login}@example.com" }
  u.password "password"
  u.password_confirmation "password"
  u.persistence_token { |u| "#{u.login}-persistence_token" }
  u.single_access_token { |u| "#{u.login}-single_access_token" }
  u.perishable_token { |u| "#{u.login}-perishable_token" }
end