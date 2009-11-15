xml.instruct! :xml, :version=>'1.0', :encoding=>'utf-8'

xml.feed 'xmlns' => 'http://www.w3.org/2005/Atom', 'xml:lang' => 'en' do
  xml.title 'Dreams'
  xml.link 'rel' => 'alternate', 'href' => dreams_url
  xml.link 'rel' => 'self', 
           'href' => dreams_url(:format => :atom),
           'type' => 'application/atom+xml'
  xml.id dreams_url(:format => :atom)
  xml.updated Time.now.utc.strftime("%Y-%m-%dT%H:%M:%SZ")
  xml.generator 'niarevo.com', 'uri' => 'http://www.niarevo.com'

  @dreams.each do |dream|
    xml.entry do
      xml.link    "rel" => "alternate", 
                  "href" => dream_url(dream)

      xml.id      "tag:#{request.host},#{dream.updated_at.strftime('%Y-%m-%d')}:#{dream.id}"
      xml.title truncate(dream.description)
      xml.author do
        xml.name dream.user ? dream.user.login : 'Anonymous Dreamer'
        xml.uri dream.user ? user_dreams_url(dream.user.login) : dreams_url
      end
      xml.updated dream.updated_at.strftime("%Y-%m-%dT%H:%M:%SZ")
      xml.published dream.created_at.strftime("%Y-%m-%dT%H:%M:%SZ")
      xml.content render_markdown(dream.description), :type => 'html'
    end
  end

end
