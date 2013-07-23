use strict;
use warnings;
use Test::More tests => 5;                      # last test to print

use Log::LTSV;

my $obj = Log::LTSV->new;

can_ok($obj, 'info');
can_ok($obj, 'debug');
can_ok($obj, 'error');
can_ok($obj, 'warning');
can_ok($obj, 'fatal');

done_testing();

