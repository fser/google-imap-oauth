#!/usr/bin/env perl

use warnings;
use strict;

use GoogleOAuth;
use Mail::IMAPClient;
use Config::Simple;

my $cfg = new Config::Simple('settings.ini');

my $token = shift || $cfg->param('oauth2_token');

my $imap = Mail::IMAPClient->new(
     Server        => 'imap.gmail.com',
     Port          => 993,
     Ssl           => 1,
     Uid           => 1,
				);

$imap->authenticate('XOAUTH2', sub { $token }) or die ($!);
print "$_\n" for $imap->folders;
