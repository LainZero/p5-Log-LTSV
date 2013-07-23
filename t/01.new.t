use strict;
use warnings;
use Test::More tests => 2;

use Log::LTSV;

subtest 'no args' => sub {
    my $obj = Log::LTSV->new;
    isa_ok $obj, 'Log::LTSV';
};

subtest 'logpath => /tmp' => sub {
    my $obj = Log::LTSV->new( logpath => '/tmp' );
    isa_ok $obj, 'Log::LTSV';
};

done_testing();

