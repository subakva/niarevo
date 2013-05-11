FactoryGirl.define do
  factory :dream do
    description %{
      In publishing and graphic design, lorem ipsum is placeholder
      text (filler text) commonly used to demonstrate the graphics elements of a
      document or visual presentation, such as font, typography, and layout, by
      removing the distraction of meaningful content. The lorem ipsum text is
      typically a section of a Latin text by Cicero with words altered, added and
      removed that make it nonsensical in meaning and not proper Latin.
    }.squish
    user
    content_tag_list ['no-pants', 'crocodiles']
    context_tag_list ['school', 'math-class']

    trait :anonymous do
      user nil
    end

    trait :untagged do
      content_tag_list []
      context_tag_list []
    end
  end
end
