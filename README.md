# AlcatrazSearch-packages
Package list repository for AlcatrazSearch

# Getting Started

Requirement:

* Ruby 2.3+
* [Heroku Toolbelt](https://toolbelt.heroku.com/)

Install dependencies:


```
bundle install --path=vendor/bundle
```

heroku settings:


```
heroku login
heroku create alcatraz-search-packages
git push heroku master
heroku run "ruby alcatraz.rb"
heroku config:add EMAIL="YOUR_GMAIL_ADDRESS"
heroku config:add PASSWORD="YOUR_GMAIL_PASSWORD"
heroku config:add GH_TOKEN="YOUR_GITHUB_TOKEN"
heroku config:add DROPBOX_TOKEN="YOUR_FULL_DROPBOX_PERMISSION_TOKEN"
heroku run "ruby alcatraz.rb"
```
