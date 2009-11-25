# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#   
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Major.create(:name => 'Daley', :city => cities.first)

json_text = File.read(File.join(RAILS_ROOT, 'db', 'seeds', 'dreamtagger-export.json'))
sources = JSON::Parser.new(json_text).parse
sources.each do |source|
  model_type = source['model']
  fields = source['fields']
  case model_type
  when 'auth.user'                        # ["groups", "is_staff", "last_login", "username", "user_permissions", "date_joined", "is_active", "last_name", "password", "email", "is_superuser", "first_name"]
    username = fields["username"]
    username = 'oldadmin' if username == 'admin'
    unless User.exists?(:username => username)
      record = User.new(
        :username => username,
        :last_login_at => fields["last_login"],
        :created_at => fields["date_joined"],
        :email => fields["email"],
        :password => fields["password"],
        :password_confirmation => fields["password"]
      )
    end
  when 'dreams.dream'                     # ["created_on", "text", "tags", "modified_on", "user"]
    unless Dream.exists?(:created_at => fields['created_on'], :user_id => fields['user'])
      record = Dream.new(
        :description => fields['text'],
        :user_id => fields['user'],
        :dream_tag_list => fields['tags'],
        :created_at => fields['created_on'],
        :updated_at => fields['modified_on']
      )
    end
  when 'accounts.profile'                 # ["created_on", "modified_on", "invited_by", "user"]
  when 'registration.registrationprofile' # ["activation_key", "user"]
  when 'tagging.tag'                      # ["name"]
  when 'tagging.taggeditem'               # ["content_type", "tag", "object_id"]
  when 'sites.site'                       # ["name", "domain"]
  when 'sessions.session'                 # ["expire_date", "session_data"]
  when 'contenttypes.contenttype'         # ["name", "model", "app_label"]
  when 'admin.logentry'                   # ["action_flag", "content_type", "change_message", "action_time", "user", "object_id", "object_repr"]
  else
    puts "Unhandled type: #{model_type}"
    puts "fields.keys.inspect = #{fields.keys.inspect}<br/>"
    # puts "fields.inspect = #{fields.inspect}<br/>"
  end
  if record
    record.id = source['pk']
    record.save!
  end
end
