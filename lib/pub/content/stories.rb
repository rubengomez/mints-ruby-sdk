# frozen_string_literal: true

module Stories
  ##
  # === Get Stories.
  # Get a collection of stories.
  #
  # ==== Parameters
  # options:: (Hash) -- List of {Resource collection Options}[#class-Mints::Pub-label-Resource+collections+options+] shown above can be used as parameter.
  # use_post:: (Boolean) -- Variable to determine if the request is by 'post' or 'get' functions.
  #
  # ==== First Example
  #     @data = @mints_pub.get_stories
  #
  # ==== Second Example
  #     options = { fields: 'id, slug' }
  #     @data = @mints_pub.get_stories(options)
  #
  # ==== Third Example
  #     options = {
  #       fields: 'id, slug'
  #     }
  #     @data = @mints_pub.get_stories(options, false)
  def get_stories(options = nil, use_post = true)
    get_query_results('/content/stories', options, use_post)
  end

  ##
  # === Get Story.
  # Get a single story.
  #
  # ==== Parameters
  # slug:: (String) -- It's the string identifier generated by Mints.
  # options:: (Hash) -- List of {Single Resource Options}[#class-Mints::Pub-label-Single+resource+options] shown above can be used as parameter.
  #
  # ==== First Example
  #     @data = @mints_pub.get_story("story_slug")
  #
  # ==== Second Example
  #     @data = @mints_pub.get_story("story_slug", options.to_json)
  def get_story(slug, options = nil)
    @client.raw('get', "/content/stories/#{slug}", options)
  end
end
