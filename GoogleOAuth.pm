package GoogleOAuth;

#!/usr/bin/env perl
#
# François Serman (aifsair@gmail.com)

use warnings;
use strict;

BEGIN {
				require Exporter;
				our $VERSION = 1.00;
				our @ISA = qw(Exporter);
				our @EXPORT = qw(generate_OAuth2_token authorize_token refresh_token generate_OAuth2_string);
}


my $BASE_URL = 'https://accounts.google.com';
my $REDIRECT_URI = 'urn:ietf:wg:oauth:2.0:oob';

sub encode_params
{
    my $values = $_[0];
    my @stack;

    foreach (keys(%{$values}))
    {
								push(@stack, sprintf("%s=%s", $_, $values->{$_}));
    }
    join('&', @stack);
}

sub accounts_url
{
    $BASE_URL . '/' . $_[0];
}

sub generate_OAuth2_token
{
    my ($client_id) = $_[0];
    my %params = ('client_id', $client_id,
		  'redirect_uri', $REDIRECT_URI,
		  'scope', 'https://mail.google.com/', # HARDCODED
		  'response_type', 'code');

    accounts_url('o/oauth2/auth') . '?' . encode_params(\%params);
}

sub authorize_token
{
    use LWP::Simple;
    use JSON;

    my ($client_id, $client_secret, $authorization_code) = @_;


    my $url = accounts_url('o/oauth2/token');
    my $browser = LWP::UserAgent->new;
    my $response = $browser->post($url, [ 'client_id' => $client_id,
					  'client_secret' => $client_secret,
					  'code' => $authorization_code,
					  'redirect_uri' => $REDIRECT_URI,
					  'grant_type' => 'authorization_code' ]);

    die "Can't post $url -- ", $response->status_line
								unless $response->is_success;

    decode_json ($response->content);
}


sub refresh_token
{
    use LWP::Simple;
    use JSON;

    my ($client_id, $client_secret, $refresh_token) = @_;

    my $url = accounts_url('o/oauth2/token');
    my $browser = LWP::UserAgent->new;
    my $response = $browser->post($url, [ 'client_id' => $client_id,
					  'client_secret' => $client_secret,
					  'refresh_token' => $refresh_token,
					  'grant_type' => 'refresh_token' ]);

    die "Can't post $url -- ", $response->status_line
								unless $response->is_success;

    decode_json ($response->content);
}

sub generate_OAuth2_string
{
    use MIME::Base64;

    my ($username, $access_token) = @_;

    encode_base64(sprintf("user=%s\1auth=Bearer %s\1\1", $username, $access_token), ''); # Otherwize a linefeed comes
}

1;
__END__
