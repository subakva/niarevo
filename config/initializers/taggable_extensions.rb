module TaggingExtensions
  def self.extended(klass)
    klass.class_eval do
      belongs_to :user
    end
  end
end
Tagging.send(:extend, TaggingExtensions)

module TagExtensions
  def self.extended(klass)
    klass.class_eval do
      belongs_to :user
    end
  end
end
Tag.send(:extend, TagExtensions)

module TaggableByUser
  def self.included(klass)
    klass.class_eval do
      def add_new_tags_with_user(tag_kind)
        tag_names = tags.of_kind(tag_kind).map(&:name)
        get_tag_list(tag_kind).each do |tag_name| 
          next if tag_names.include?(tag_name)
          tag = Tag.find_or_initialize_with_name_like_and_kind(tag_name, tag_kind)
          tag.user = self.tagged_by if tag.new_record?
          tags << tag
          self.taggings.each do |tagging|
            if tagging.tag == tag
              tagging.user = self.tagged_by
            end
          end
        end
      end
      alias_method_chain :add_new_tags, :user
    end
  end
end
