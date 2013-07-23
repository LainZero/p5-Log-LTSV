#############################################################################
#   Program: Log::LTSV.pm
#   Purpose: Output the process log by level using Labeled Tab Separated.
# Revisions:
#   2013/06/04  yoshitomoued    Initial
#############################################################################
package Log::LTSV;
use strict;
use warnings;
our $VERSION = '0.09';

use Fcntl ":flock";
use File::Basename;
use IO::File;
use POSIX 'strftime';
use Sys::Hostname;


sub new {
    my ( $class, %args ) = @_;
    my $self = bless{ %args }, $class;
    $self->{level} ||= 'INFO';
    return $self;
}

sub _write {
    my $self = shift;
    my $date = $self->_getDate();
    my $datetime = $self->_getDateTime();
    my @extlist = ('.pl','.pm');
    my $scriptname = basename ( $0, @extlist );
    my $logfile = $self->{logpath} . "/" . $scriptname . $date . ".log";
    my $log = IO::File->new(">>$logfile");
    flock($log, LOCK_EX);
    $log->printf ("time:[%s]\thost:%s\tpid:%d\tlevel:[%s]\tmsg:%s\n"
                    , $datetime
                    , hostname()
                    , $$
                    , $self->{level}
                    , $self->{msg});
    chmod 0664, $logfile;
    flock($log, LOCK_UN);
    $log->close;
    return $self;
}

sub _getDate {
    my $date = strftime "%Y%m%d", localtime;
    return $date;
}

sub _getDateTime {
    my $datetime = strftime "%F %T", localtime;
    return $datetime;
}

sub info {
    my ($self, $msg) = @_;
    $self->{msg} = $msg;
    $self->{level} = 'INFO';
    $self->_write();
    return;
}

sub debug {
    my ($self, $msg) = @_;
    $self->{msg} = $msg;
    $self->{level} = 'DEBUG';
    $self->_write();
    return;
}

sub warning {
    my ($self, $msg) = @_;
    $self->{msg} = $msg;
    $self->{level} = 'WARN';
    $self->_write();
    return;
}

sub error {
    my ($self, $msg) = @_;
    $self->{msg} = $msg;
    $self->{level} = 'ERROR';
    $self->_write();
    return;
}

sub fatal {
    my ($self, $msg) = @_;
    $self->{msg} = $msg;
    $self->{level} = 'FATAL';
    $self->_write();
    return;
}

1; # Magic true value required at end of module
__END__

=head1 NAME

Log::LTSV - Output process log file used LTSV format

=head1 VERSION

This document describes Log::LTSV version 0.09

=head1 SYNOPSIS

    use Log::LTSV;
    my $log = Log::LTSV->new( 'logpath' => '/tmp' );
    
    # for Information log
    $log->info( "Information" );
    # Output
    # time:[2013-06-14 17:46:03]      host:nanoha   pid:13130       level:[INFO]    msg:Information
    
    # for debug message
    $log->debug( "Debug message" );
    # Output
    # time:[2013-06-14 17:46:03]      host:nanoha   pid:13130       level:[DEBUG]   msg:Debug message
    
    # for warning message
    $log->warning( "Warning message" );
    # Output
    # time:[2013-06-14 17:46:03]      host:nanoha   pid:13130       level:[WARN]    msg:Warning message
    
    # for error message
    $log->error( "Error message" );
    # Output
    # time:[2013-06-14 17:46:03]      host:nanoha   pid:13130       level:[ERROR]   msg:Error message
    
    # for fatal message
    $log->fatal( "Fatal Message" );
    # Output
    # time:[2013-06-14 17:46:03]      host:nanoha   pid:13130       level:[FATAL]   msg:Fatal message

=head1 DESCRIPTION

The log of a process is outputted in a LTSV format.
LTSV (Labeled Tab-separated Values) format is a a variant of
Tab-separated Values (TSV).

cf: L<http://ltsv.org/>

An output filename is automatically set to <program><date>.log
E.g. if logtest.pl, output is logtest20130614.log

=head1 DEPENDENCIES

    Fcntl
    File::Basename
    IO::File
    POSIX
    Sys::Hostname

=head1 BUGS

No known bugs.

=head1 AUTHOR

Yoshitomo Ueda  C<< <lainzero@gmail.com> >>

=head1 SEE ALSO

L<Text::LTSV>

=head1 LICENCE AND COPYRIGHT

Copyright (c) 2013, Yoshitomo Ueda C<< <lainzero@gmail.com> >>. All rights reserved.

This module is free software; you can redistribute it and/or
modify it under the same terms as Perl itself.

=cut


