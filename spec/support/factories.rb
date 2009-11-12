Factory.sequence :login do |n|
  "knocker#{n}"
end

Factory.define :user do |u|
  u.login { Factory.next :login }
  u.email { |u| "#{u.login}@example.com" }
  u.password "password"
  u.password_confirmation "password"
end