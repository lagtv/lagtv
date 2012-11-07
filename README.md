LAGTV Website
=============

Calling all fans of [LAGTV](http://www.youtube.com/user/LifesAGlitchTV). We, the bouses and bousettes of LAGTV are building an awesome website for the community. Let's keep it open source and freely available so the guys always have access to it.

Useful Links
============

* [Live Site](http://www.lag.tv)
* [Test Site](http://lagtv.andypike.com)
* [Discussion Group](http://groups.google.com/group/lagtv-website?hl=en)
* [Issue Tracker](https://github.com/andypike/lagtv/issues)

How you can help
================

Developers
----------

If you know Ruby on Rails then you can help. Just fork this repro then create a feature branch for your changes. Please do not add changes to the master branch. When you are done, send a pull request and the core team will review the changes and then merge into master.

Make sure your changes are covered by test. Pull requests without tests will be rejected.

We haven't tried setting up the development environment on Windows, but OSX and Linux will be fine. Here's how to get setup:

1. Install Ruby (we use RVM)
2. Install Postgresql (we use Homebrew)
3. Create a database called lagtv_development with a user called lagtv
4. Setup your config by copying the following and changing as required:
  1. ```$ cp config/database.example.yml config/database.yml```
  2. ```$ cp config/application.example.yml config/application.yml```
  3. ```$ cp config/newrelic.example.yml config/newrelic.yml```
5. Run ```$ bundle```
6. Run ```$ rake db:setup```
7. Start the webserver with ```$ rails s```
8. See the site running at http://localhost:3000

Once you are all setup, pick an issue from the current release (see below) and code away :smile:. If you are unsure of what to work on or need help setting up, post a message in the [discussion group](http://groups.google.com/group/lagtv-website?hl=en) and one of us will help you get started.

Testers
-------

Get on the test site and try it out. If you find a problem, create issues [here in the github issue tracker](https://github.com/andypike/lagtv/issues). Don't worry about breaking anything, just do whatever you fancy. We'll reset the database from time to time on this server. Keep an eye of the [discussion group](http://groups.google.com/group/lagtv-website?hl=en) where we announce upgrades to the testing server with details of what has changed.

Designers
---------

Take a look at the website and if you feel the user interface could be improved in certain areas then create a mock up and post it in the [discussion group](http://groups.google.com/group/lagtv-website?hl=en). Once we have discussed and accepted it, you might be asked for some assets (probably just PSDs) while we add your design.

Everyone
--------

We are always on the look out for new ideas for improving the site. If you've spotted a problem, large or small, or you have a feature request you can [discuss it with the group](http://groups.google.com/group/lagtv-website?hl=en) first and then create an issue in the [issue tracker](https://github.com/andypike/lagtv/issues) for us to pick up.

Releases
========

Release Planning
----------------

* We will gather feedback from the community and if its a new, valid issue we will add it to the issue tracker.
* After discussion we will either add the issue to the [backlog](https://github.com/andypike/lagtv/issues?milestone=5&page=1&state=open) or close it depending if we feel this is an issue that we should deal with or it needs further investigation.
* At the beginning of a release cycle, we will review the backlog and select a number of issues that should make up the next release.
* We will try to keep releases small but often

Current Release
---------------

The next release is in planning.

Process
-------

Here's how releases will work in general. 

* Developers can pick issues from the current release to work on
* At various points during the release we will upgrade the test site and announce it in the discussion group.
* Testers can review the changes and report issues.
* The developers will fix the issues until the milestone is complete and the testers are happy.
* We will ask Adam and Jeff to review the test site and give us approval to upgrade live.
* We will publish the changes in the discussion group and in the forum

Changelog
---------

**[1.0.1](https://github.com/andypike/lagtv/issues?milestone=8&page=1&state=open)**

* Site wide SSL for increased security.
* The "My Profile" link has been replaced with the logged in username and avatar.
* Forum signatures now part of the users profile and added to all posts by that user. Admins and CMs can hide a users signature if required.
* Homepage "Latest Forum Activity" list now excludes support category posts and displays the relative date of the post.
* Registration captcha now accepts answers in digits and words.
* Added new "Dev Team" role for those people actively developing and supporting the website.
* Images in the forums now have a max width and height so they do not go outside the bounds.
* BUG FIX: Users can now updated their own profile with receiving a permissions error.

**1.0.0**

* Initial release

Thank you
=========

A big thank you to everyone that has helped with the site so far. It's been a great community effort and I know that Adam and Jeff are very happy with what we have done so far.

Bouse!
