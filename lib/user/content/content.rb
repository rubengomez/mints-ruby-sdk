require_relative './assets.rb'
require_relative './content_instances.rb'
require_relative './content_templates.rb'
require_relative './conversations.rb'
require_relative './dam.rb'
require_relative './forms.rb'
require_relative './message_templates.rb'
require_relative './messages.rb'
require_relative './pages.rb'
require_relative './stories.rb'
require_relative './story_versions.rb'
require_relative './story_templates.rb'

module Content
    include Assets
    include ContentInstances
    include ContentTemplates
    include Conversations
    include DAM
    include Forms
    include MessageTemplates
    include Messages
    include Pages
    include Stories
    include StoryVersions
    include StoryTemplates

    # === Get public images url.
    # Get public images url.
    #
    # ==== Example
    #     @data = @mints_user.get_public_images_url
    def get_public_images_url
        return @client.raw("get", "/content/public-images-url")
    end

    ##
    # == Authors
    #

    # === Get authors.
    # Get authors.
    #
    # ==== Example
    #     @data = @mints_user.get_authors
    def get_authors
        return @client.raw("get", "/content/authors")
    end


    # === Get author.
    # Get an author.
    #
    # ==== Parameters
    # id:: (Integer) -- Author id.
    #
    # ==== Example
    #     @data = @mints_user.get_author(1)
    def get_author(id)
        return @client.raw("get", "/content/authors/#{id}")
    end

    # === Create author.
    # Create an author with data.
    #
    # ==== Parameters
    # data:: (Hash) -- Data to be submitted.
    #
    # ==== Example
    #     data = {
    #       "title": "Howard Phillips Lovecraft",
    #       "slug": "howard-phillips-lovecraft"
    #     }
    #     @data = @mints_user.create_author(data.to_json)
    def create_author(data)
        return @client.raw("post", "/content/authors", nil, data)
    end

    # === Update author.
    # Update an author info.
    #
    # ==== Parameters
    # id:: (Integer) -- Author id.
    # data:: (Hash) -- Data to be submitted.
    #
    # ==== Example
    #     
    def update_author(id, data)
        #FIXME: Author controller doesnt receive data
        return @client.raw("put", "/content/authors/#{id}", nil, data)
    end

    ##
    # == Keywords
    #

    # === Get keywords.
    # Get a collection of keywords.
    #
    # ==== Parameters
    # options:: (Hash) -- List of Resource Collection Options shown above can be used as parameter.
    #
    # ==== First Example
    #     @data = @mints_user.get_keywords
    #
    # ==== Second Example
    #     options = { "fields": "title" }
    #     @data = @mints_user.get_keywords(options)
    def get_keywords(options = nil)
        return @client.raw("get", "/content/keywords", options)
    end
    
    # === Get keyword.
    # Get a keyword.
    #
    # ==== Parameters
    # id:: (Integer) -- Keyword id.
    #
    def get_keyword(id)
        return @client.raw("get", "/content/keywords/#{id}")
    end

    # === Create keyword.
    # Create a keyword with data.
    #
    # ==== Parameters
    # data:: (Hash) -- Data to be submitted.
    #
    # ==== Example
    #     data = {
    #       "title": "New Keyword"
    #     }
    #     @data = @mints_user.create_keyword(data.to_json)
    def create_keyword(data)
        return @client.raw("post", "/content/keywords", nil, data)
    end

    # === Update keyword.
    # Update a keyword info.
    #
    # ==== Parameters
    # id:: (Integer) -- Keyword id.
    # data:: (Hash) -- Data to be submitted.
    #
    # ==== Example
    #     
    def update_keyword(id, data)
        #FIXME: Keyword controller doesnt receive data
        return @client.raw("put", "/content/keywords/#{id}", nil, data)
    end

    ##
    # == Stages
    #    

    # === Get stages.
    # Get a collection of stages.
    #
    # ==== Parameters
    # options:: (Hash) -- List of Resource Collection Options shown above can be used as parameter.
    #
    # ==== First Example
    #     @data = @mints_user.get_stages
    #
    # ==== Second Example
    #     options = { "fields": "title" }
    #     @data = @mints_user.get_stages(options)
    def get_stages(options = nil)
        return @client.raw("get", "/content/stages", options)
    end

    # === Get stage.
    # Get a stage.
    #
    # ==== Parameters
    # id:: (Integer) -- Stage id.
    #
    # ==== Example
    #     @data = @mints_user.get_stage(1)
    def get_stage(id)
        return @client.raw("get", "/content/stages/#{id}")
    end

    # === Create stage.
    # Create a stage with data.
    #
    # ==== Parameters
    # data:: (Hash) -- Data to be submitted.
    #
    # ==== Example
    #     config_json = {
    #       "count": 1
    #     }
    #     event_json = {
    #       "rset": "DTSTART:20190214T000000Z",
    #       "duration": 1
    #     }
    #     data = {
    #       "title": "New Stage",
    #       "description": "New Stage Description",
    #       "config_json": config_json.to_json,
    #       "event_json": event_json.to_json
    #     }
    #     @data = @mints_user.create_stage(data.to_json)
    def create_stage(data)
        return @client.raw("post", "/content/stages", nil, data)
    end

    # === Update stage.
    # Update a stage info.
    #
    # ==== Parameters
    # id:: (Integer) -- Stage id.
    # data:: (Hash) -- Data to be submitted.
    #
    # ==== Example
    #     config_json = {
    #       "count": 2
    #     }
    #     event_json = {
    #       "rset": "DTSTART:20190214T000000Z",
    #       "duration": 2
    #     }
    #     data = {
    #       "stageProps": { 
    #         "title": "New Stage Modified",
    #         "description": "New Stage Description Modified"
    #       },
    #       "config_json": config_json.to_json,
    #       "event_json": event_json.to_json
    #     }
    #     @data = @mints_user.update_stage(3, data.to_json)
    def update_stage(id, data)
        #TODO: Inform StageController.update method has been modified
        return @client.raw("put", "/content/stages/#{id}", nil, data)
    end
end