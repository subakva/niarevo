[![Code Climate](https://codeclimate.com/github/subakva/niarevo.png)](https://codeclimate.com/github/subakva/niarevo)
[![Build Status](https://travis-ci.org/subakva/niarevo.png)](https://travis-ci.org/subakva/niarevo)

Deployment
----

    $ git push production master

Next
----

* Spec coverage
  * account management (change: email, username, password)
  * dream help content
  * unit tests (password_reset_request, activation_request, dream_tagger_control)
* drop taggings and tags tables
* switch to webpacker for assets
* upgrade postgres to 9.6
* bootsnap
* change activejob adapter?
* remove jquery (this would require getting rid of bootstrap)
* remove jquery.form.js
* remove coffee-rails (only used for preview.js)
* remove unf ?what is this used for?
* switch from travis to circle?
* switch from rdiscount to kramdown
* switch to rollbar

* set up heroku review apps
  - set up staging with all config vars
  - use staging as the parent for review apps so it can inherit config vars
  - generate app.json from staging
  - etc.

* switch to sorcery?
* better tag input (https://github.com/maxwells/bootstrap-tags)
* convert help modals to popovers
* Statistically improbable phrases (tag generation)
* Detect correlated tags
* Invitations
* test data generation
* record who added which tags to dreams
* delete tags
* remove recording of last_request_at for all user requests
* email delivery via girl friday: http://mperham.github.io/girl_friday/

## User Personas ##

  * __Dreamer__ - The dreamer is a person who has dreams, and wants to record and share them with the world.
  * __Voyeur__ - The voyeur is a person who likes to read about other people's dreams. This person is interested in how dreams affect the world and how the world affects dreams.
  * __Interpreter__ - The interpreter is a person who likes to read other people's dreams and try to explain them. This person is interested in explaining how dreams reflect reality.
  * __Admin__ - The admin wants to make sure all the recorded dreams are safe and happy.

## Future Features ##

  * Dreams
    * Attach images/files to a dream
    * Safe HTML formatting in dream description
    * ? Attach disqus comments to dreams
  * Stickiness
    * Add badges for
      * creating 1/10/100/100 dreams
      * tagging 1/10/100/1000 dreams
    * Favorites
  * Tags
    * Associate user with tags/taggings
    * Editing tags on a dream
    * Captcha for anonymous tags
    * Tag cloud
    * Tag zeitgeist
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
  * API
    * Access dream data with an API key
  * Tracking
    * Customized latest dreams by search terms
  * Email
    * Submit a dream by email
    * Receive notifications about new dreams for a search term (person/tag/text)
  * Infrastructure/Performance
    * Cookie-less Media Domains (config.action_controller.asset_host)
    * Page Caching
    * buy an ssl certificate
    * SSL Enforcement (needs $$ on heroku...)
    * A/B Testing

## Completed Features ##

  * Dreams
    * Recording a new dream
    * Automatic markdown formatting
    * Showing a list of dreams
    * Import data from the previous version
    * Captcha for anonymous dreams
    * Preview Dream Description
    * Private Dreams
  * Tags
    * Browsing dreams by tags
    * Ability to tag for content or context
    * Browse untagged dreams
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
    * Cross-browser test the design
    * iPhone-friendly stylesheet
    * better full-page form styling
    * better mobile icon sizing
  * Static Content
    * Import about page from dreamtagger
    * Import feeds page from dreamtagger
    * Import terms page from dreamtagger
  * Infrastructure/Performance
    * foreign key constraints
    * Error Reporting
    * Analytics
    * alternate tags for atom feeds
    * switch to a proper host
    * generate sitemap (http://github.com/adamsalter/sitemap_generator)
