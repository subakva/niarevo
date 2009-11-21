Factory.sequence :username do |n|
  "knocker#{n}"
end

Factory.define :user do |u|
  u.username { Factory.next :username }
  u.email { |u| "#{u.username}@example.com" }
  u.password "password"
  u.password_confirmation "password"
  u.persistence_token { |u| "#{u.username}-persistence_token" }
  u.single_access_token { |u| "#{u.username}-single_access_token" }
  u.perishable_token { |u| "#{u.username}-perishable_token" }
end

Factory.define :dream do |d|
  d.description 'It was a stormy and dark night'
  d.tag_list 'cliche, storm, night'
end
