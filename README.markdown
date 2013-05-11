Next:

* Spec coverage of features
  * account management (change email, username, password)
  * edit own dreams
  * preview dream formatting
  * dream help content
  * list dreams by month
  * list dreams by day
  * list dreams by dream tag
  * list dreams by dreamer tag
  * list dreams without dream tags
  * list dreams without dreamer tags
  * zeitgeist
  * static pages
  * unit tests (password_reset_request, activation_request, dream_tagger_control)

* rename content_tags to dream_tags and context_tags to dreamer_tags
* Rails 4
* better full-page form styling
* better mobile icon sizing
* better tag input (https://github.com/maxwells/bootstrap-tags)
* convert help modals to popovers
* Private dreams
* Statistically improbable phrases (tag generation)
* Detect correlated tags
* Invitations
* Facebook integration
* Multiple asset hosts
* Caching
* test data generation
* travis
* code climate
* record who added which tags to dreams
* delete tags
* remove recording of last_request_at for all user requests
* girl friday: http://mperham.github.io/girl_friday/

To resurrect:


## User Personas ##

  * __Dreamer__ - The dreamer is a person who has dreams, and wants to record and share them with the world.
  * __Voyeur__ - The voyeur is a person who likes to read about other people's dreams. This person is interested in how dreams affect the world and how the world affects dreams.
  * __Interpreter__ - The interpreter is a person who likes to read other people's dreams and try to explain them. This person is interested in explaining how dreams reflect reality.
  * __Admin__ - The admin wants to make sure all the recorded dreams are safe and happy.

## Completed Features ##

  * Dreams
    * Recording a new dream
    * Automatic markdown formatting
    * Showing a list of dreams
    * Import data from the previous version
    * Captcha for anonymous dreams
    * Preview Dream Description
  * Tags
    * Browsing dreams by tags
    * Ability to tag for content or context
    * Associate user with tags/taggings
    * Browse untagged dreams
    * Tag cloud
    * Tag zeitgeist
  * RSS Feeds
    * For anonymous dreams
    * For a user
    * For a tag
    * For a date
  * Accounts
    * Create a dreamer account
    * Change password
    * Change account preferences
    * Account activation process
    * Back end for invitation system
  * Infrastructure/Performance
    * Asset Packaging
  * Design
    * Ported design from dreamtagger
    * Switch base styles to blueprint
    * Set up HTML title tags
  * Static Content
    * Import about page from dreamtagger
    * Import feeds page from dreamtagger
    * Import terms page from dreamtagger
  * Infrastructure/Performance
    * foreign key constraints
    * Error Reporting
    * Cookie-less Media Domains (config.action_controller.asset_host)
    * Analytics
    * alternate tags for atom feeds
    * switch to a proper host
    * generate sitemap (http://github.com/adamsalter/sitemap_generator)
    * move to linode
      * set up environment
        * mysql
        * nginx
        * ree
        * passenger
      * deploy application to linode
      * switch dns to linode
      * set up reverse dns for linode
      * setup ssl

## Future Features ##

  * Dreams
    * Private Dreams
    * Attach images/files to a dream
    * . Safe html formatting
    * ? Attach disqus comments to dreams
  * Stickiness
    * Add badges for
      * creating 1/10/100/100 dreams
      * tagging 1/10/100/1000 dreams
    * Favorites
  * Tags
    * Editing tags on a dream
    * Captcha for anonymous tags
  * Searching
    * Finding dreams with certain text
    * Finding with certain tags
    * Finding dreams for a certain user
    * Finding dreams for a date range
  * Accounts
    * !! Front-end for invitation system
    * opt out of invitations
    * communication preferences
    * Delete a dreamer account
    * Add time zone support
    * Add an admin? flag that allows a user to edit anything.
  * Design
    * !! Cross-browser test the design
    * iPhone-friendly stylesheet
  * API
    * Access dream data with an API key
  * Tracking
    * Customized latest dreams by search terms
  * Email
    * Submit a dream by email
    * Receive notifications about new dreams for a search term (person/tag/text)
  * Infrastructure/Performance
    * Page Caching
    * SSL Enforcement (needs $$ on heroku...)
    * A/B Testing
    * set up memcached
    * buy an ssl certificate

