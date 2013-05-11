class PasswordResetRequest
  extend ActiveModel::Naming
  extend ActiveModel::Translation
  include ActiveModel::Conversion
  include ActiveModel::Validations

  validates :username_or_email, presence: true
  validates_presence_of :user, message: "Sorry, we couldn't find that account."
  validate :user_is_active

  attr_accessor :username_or_email
  attr_reader :user

  def initialize(params = {})
    @params = params
    @params.each do |attr, value|
      self.public_send("#{attr}=", value)
    end if @params
  end

  def create
    return false unless valid?
    user.deliver_password_reset_instructions!
  end

  def user
    @user ||= User.find_by_username_or_email(@params)
  end

  def active_user?
    user && user.active?
  end

  def inactive_user?
    !active_user?
  end

  def user_is_active
    errors.add(:base, 'That account is not yet active.') if inactive_user?
  end

  def persisted?
    false
  end

end
