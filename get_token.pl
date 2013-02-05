#!/usr/bin/env perl

use warnings;
use strict;

use GoogleOAuth;
use Config::Simple;

my $cfg = new Config::Simple('settings.ini');

my $auth_string = generate_OAuth2_string($cfg->param('username'), 
																																									refresh_token($cfg->param('client_id'), $cfg->param('client_secret'), $cfg->param('refresh_token'))->{access_token});

$cfg->param('oauth2_token', $auth_string);
$cfg->save();

