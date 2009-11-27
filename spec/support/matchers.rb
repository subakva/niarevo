class BeAssociatedWithUser
  def initialize(expected_user)
    @expected = expected_user
  end

  def matches?(tag_names)
    @actual = tag_names
    tag_names.each do |name|
      tag = Tag.find_by_name(name)
      tag.should_not == nil
      tag.user.should == @expected
    end
    true
  end

  def failure_message_for_should
    "expected #{@actual.inspect} to be associated with user #{@expected.inspect}, but wasn't"
  end

  def failure_message_for_should_not
    "expected #{@actual.inspect} not to be associated with user #{@expected.inspect}, but was"
  end
end

def be_associated_with_user(expected_user)
  BeAssociatedWithUser.new(expected_user)
end
