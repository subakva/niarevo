Factory.sequence :username do |n|
  "knocker#{n}"
end

Factory.sequence :invitee do |n|
  "invitee#{n}@example.com"
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
  d.content_tag_list 'cliche, storm, night'
  d.context_tag_list 'in-bed'
end

Factory.define :invite do |i|
  i.message "Lorem ipsum dolor sit amet, consectetur adipisicing elit..."
  i.recipient_name { (Factory.next :username).upcase }
  i.email { Factory.next :invitee }
  i.user { |x| x.association(:user) }
end
