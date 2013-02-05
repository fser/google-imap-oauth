#!/usr/bin/env perl

use warnings;
use strict;

use GoogleOAuth;
use Config::Simple;

my $cfg = new Config::Simple('settings.ini');

print generate_OAuth2_token($cfg->param('client_id')) , "\n";
print "Enter Validation code: ";
my $authorization_code = <>;

my $data = authorize_token($cfg->param('client_id'), $cfg->param('client_secret'), $authorization_code);

$cfg->param('refresh_token', $data->{refresh_token});
$cfg->param('access_token', $data->{access_token});
$cfg->save();

print "Config file updated successfuly. You can now run client.pl :)\n";


