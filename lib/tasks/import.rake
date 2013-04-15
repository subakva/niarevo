namespace :db do
  task import: :environment do
    Bundler.require(:import)

    NIAREVO_RESTORE = {
      adapter:  "mysql2",
      host:     "localhost",
      username: "niarevo",
      password: "",
      database: "niarevo_restore"
    }

    module Old
      class Record < ActiveRecord::Base
        establish_connection NIAREVO_RESTORE
        self.abstract_class = true
        @columns = []
      end

      class User < Old::Record
        has_many :dreams, class_name: 'Old::Dream'
        has_many :invites, class_name: 'Old::Invite'
      end

      class Invite < Old::Record
        belongs_to :user, class_name: 'Old::User'
      end

      class Dream < Old::Record
        belongs_to :user, class_name: 'Old::User'
        has_many :taggings, class_name: 'Old::Tagging', foreign_key: 'taggable_id'
        has_many :tags, through: :taggings, class_name: 'Old::Tag'
      end

      class Tagging < Old::Record
        belongs_to :tag, class_name: 'Old::Tag'
      end

      class Tag < Old::Record
        has_many :taggings, class_name: 'Old::Tagging'
      end
    end

    Old::User.find_each do |old_user|
      puts "Processing user: #{old_user.username}..."
      user = User.where(username: old_user.username).first
      user ||= User.new(username: old_user.username)
      user.assign_attributes(
        id: old_user.id,
        username: old_user.username,
        email: old_user.email,
        crypted_password: old_user.crypted_password,
        password_salt: old_user.password_salt,
        persistence_token: old_user.persistence_token,
        single_access_token: old_user.single_access_token,
        perishable_token: old_user.perishable_token,
        login_count: old_user.login_count,
        failed_login_count: old_user.failed_login_count,
        last_request_at: old_user.last_request_at,
        current_login_at: old_user.current_login_at,
        last_login_at: old_user.last_login_at,
        current_login_ip: old_user.current_login_ip,
        last_login_ip: old_user.last_login_ip,
        created_at: old_user.created_at,
        updated_at: old_user.updated_at,
        active: old_user.active,
      )
      user.save!(validate: false)
      user.save!

      old_user.invites.find_each do |old_invite|
        puts "Processing invite: #{old_invite.email}..."
        invite = user.invites.where(email: old_invite.email).first
        invite ||= Invite.new
        invite.assign_attributes(
          id: old_invite.id,
          message: old_invite.message,
          recipient_name: old_invite.recipient_name,
          email: old_invite.email,
          user_id: user.id,
          sent_at: old_invite.sent_at,
          created_at: old_invite.created_at,
          updated_at: old_invite.updated_at,
        )
        invite.save!(validate: false)
        invite.save!
      end

      old_user.dreams.each do |old_dream|
        puts "Processing dream: #{old_dream.description[0..50]}..."
        dream = user.dreams.where(description: old_dream.description).first
        dream ||= Dream.new
        dream.assign_attributes(
          id: old_dream.id,
          description: old_dream.description,
          user_id: user.id,
          created_at: old_dream.created_at,
          updated_at: old_dream.updated_at,
          context_tag_list: old_dream.tags.where(kind: 'context_tag').pluck(:name),
          content_tag_list: old_dream.tags.where(kind: 'content_tag').pluck(:name),
        )
        dream.save!(validate: false)
        dream.save!

        # context_tags = old_dream.tags.where(kind: 'context_tag').pluck(:name)
        # user.tag(dream, with: context_tags, :on => :contect_tags)

        # content_tags = old_dream.tags.where(kind: 'content_tag').pluck(:name)
        # user.tag(dream, with: content_tags, :on => :content_tags)
      end
    end
  end
end
