use strict;
use warnings;
use File::Basename;
use Test::More tests => 5;
use POSIX 'strftime';

use Log::LTSV;

my $filebase = basename ($0);
my $date = strftime "%Y%m%d", localtime;
my $logpath = "/tmp";
my $file = $logpath . "/" . $filebase . $date . ".log";

subtest 'info' => sub {
    my $obj = Log::LTSV->new( 'logpath' => $logpath );
    $obj->info( "Info Test" );
    open( my $fh, "<", $file ) or die "$!:$file";
    my $line = readline $fh;
    chomp $line;
    ok $line =~ /time:\[\d{4}-\d{2}-\d{2}\s\d{2}:\d{2}:\d{2}\]\thost:\S+\tpid:\d+\tlevel:\[INFO\]\tmsg:Info Test/;
    unlink $file or die "$!:$file";
};

subtest 'debug' => sub {
    my $obj = Log::LTSV->new( 'logpath' => $logpath );
    $obj->debug( "Debug Test" );
    open( my $fh, "<", $file ) or die "$!:$file";
    my $line = readline $fh;
    chomp $line;
    ok $line =~ /time:\[\d{4}-\d{2}-\d{2}\s\d{2}:\d{2}:\d{2}\]\thost:\S+\tpid:\d+\tlevel:\[DEBUG\]\tmsg:Debug Test/;
    unlink $file or die "$!:$file";
};

subtest 'warning' => sub {
    my $obj = Log::LTSV->new( 'logpath' => $logpath );
    $obj->warning( "Warning Test" );
    open( my $fh, "<", $file ) or die "$!:$file";
    my $line = readline $fh;
    chomp $line;
    ok $line =~ /time:\[\d{4}-\d{2}-\d{2}\s\d{2}:\d{2}:\d{2}\]\thost:\S+\tpid:\d+\tlevel:\[WARN\]\tmsg:Warning Test/;
    unlink $file or die "$!:$file";
};

subtest 'error' => sub {
    my $obj = Log::LTSV->new( 'logpath' => $logpath );
    $obj->error( "Error Test" );
    open( my $fh, "<", $file ) or die "$!:$file";
    my $line = readline $fh;
    chomp $line;
    ok $line =~ /time:\[\d{4}-\d{2}-\d{2}\s\d{2}:\d{2}:\d{2}\]\thost:\S+\tpid:\d+\tlevel:\[ERROR\]\tmsg:Error Test/;
    unlink $file or die "$!:$file";
};

subtest 'fatal' => sub {
    my $obj = Log::LTSV->new( 'logpath' => '/tmp' );
    $obj->fatal( "Fatal Test" );
    open( my $fh, "<", $file ) or die "$!:$file";
    my $line = readline $fh;
    chomp $line;
    ok $line =~ /time:\[\d{4}-\d{2}-\d{2}\s\d{2}:\d{2}:\d{2}\]\thost:\S+\tpid:\d+\tlevel:\[FATAL\]\tmsg:Fatal Test/;
    unlink $file or die "$!:$file";
};

done_testing();

