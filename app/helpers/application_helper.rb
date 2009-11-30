module ApplicationHelper
  def render_markdown(markdown)
    markdown = RDiscount.new(markdown, :filter_html)
    markdown.to_html
  end

  def render_form_errors(errors)
    rendered = ''
    unless errors.blank?
      rendered << '<ul class="form-errors">'
      errors.full_messages.each do |error|
        rendered << "<li class='error-line'>#{error}</li>"
      end
      rendered << '</ul>'
    end
    rendered
  end

  def rgb_color( a, b, i, x)
    return nil if i <= 1 or x <= 1
    if a > b
      a - (Math.log(i)*(a-b)/Math.log(x)).floor
    else
      (Math.log(i)*(b-a)/Math.log(x)+a).floor
    end
  end

  def cloud_font(count, min_count, max_count, options = {})
    min_font = options.delete( :min_font_size ) || 11
    max_font = options.delete( :max_font_size ) || 14

    spread = max_count.to_f - min_count.to_f
    spread = 1.to_f if spread <= 0
    font_spread = max_font.to_f - min_font.to_f

    font_step = spread / font_spread
    font_size = ( min_font + ( count.to_f / font_step ) ).to_i
    font_size = max_font if font_size > max_font
    "font-size:#{ font_size.to_s }px"
  end

  def cloud_color(count, min_count, max_count, options = {})
    max_color = options.delete( :max_color ) || [ 0, 0, 0 ]
    min_color = options.delete( :min_color ) || [ 156, 156, 156 ]
    c = []
    (0..2).each { |i| c << rgb_color( min_color[i], max_color[i], count, max_count ) || nil }
    colors = c.compact.empty? ? min_color.join(',') : c.join(',')
    "color:rgb(#{ colors })"
  end

  def cloud_style(count, min_count, max_count, options = {})
    # Modified from: http://snippets.dzone.com/posts/show/2251
    return nil if count.nil? || max_count.nil? || min_count.nil?
    
    size_style = cloud_font(count, min_count, max_count, options = {})
    color_style = cloud_color(count, min_count, max_count, options = {})

    [ size_style, color_style ].join(';')
  end
end
