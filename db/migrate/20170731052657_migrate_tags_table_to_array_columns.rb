# frozen_string_literal: true

class MigrateTagsTableToArrayColumns < ActiveRecord::Migration[5.1]
  def up
    select_rows(%(
      select
        d.id as dream_id,
        array_to_string(array_agg(distinct dt.name)::text[], ',') as dream_tags,
        array_to_string(array_agg(distinct drt.name)::text[], ',') as dreamer_tags
      from dreams d
      left join taggings dts on dts.taggable_id = d.id and dts.context = 'dream_tags'
      left join tags dt on dt.id = dts.tag_id
      left join taggings drts on drts.taggable_id = d.id and drts.context = 'dreamer_tags'
      left join tags drt on drt.id = drts.tag_id
      group by d.id
    )).each do |(dream_id, dream_tags, dreamer_tags)|
      d = Dream.find(dream_id)
      d.dream_tags += Dream.normalize_joined_tags(dream_tags)
      d.dreamer_tags += Dream.normalize_joined_tags(dreamer_tags)
      d.save!
    end
  end

  def down; end
end
