google-imap-oauth
=================

Perl implementation of https://developers.google.com/google-apps/gmail/xoauth2_libraries

Requirements
============

This module / script collection use the following modules (available on CPAN):
* Mail::IMAPClient
* Config::Simple

How does it work?
=================

First of all, you need to register your application on https://code.google.com/apis/console \\
In the `API Access` tab, you will find 2 parameters: `Client ID`, `Client secret`.
You need to set them in the `settings.ini` file.

After that, run `perl setup.pl` to allow the application to manage your mails.
This step will update your `settings.ini` file.

If in the future, you get 4xx errors, you may need to re-run the setup phase.

You can now use token to produce `oauth_strings` (the "secret" actually needed for the
authentitcation). For that purpose, just run `perl get_token.pl` which also updates config file.

You are now ready to run the sample client.

Please see TODO bellow.


Further Resources
=================
* https://developers.google.com/accounts/docs/OAuth2
* https://developers.google.com/google-apps/gmail/oauth_overview
* http://code.google.com/p/google-mail-oauth2-tools/wiki/OAuth2DotPyRunThrough

Todo
====

* Token managing should be made easier. Right now, running the client with an expirated
  token will fail. A workaround is to run `perl get_token.pl` to update the settings file.

* Comment perl code :)
