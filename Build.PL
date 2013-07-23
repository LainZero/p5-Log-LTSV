use 5.006;
use strict;
use warnings FATAL => 'all';
use Module::Build;

my $builder = Module::Build->new(
    module_name         => 'Log::LTSV',
    license             => 'Artistic_2_0',
    dist_author         => q{Yoshitomo Ueda <lainzero@gmail.com>},
    dist_version_from   => 'lib/Log/LTSV.pm',
    release_status      => 'stable',
    configure_requires => {
        'Module::Build' => 0,
    },
    build_requires => {
        'Test::More' => 0,
    },
    requires => {
	'Fcntl'          => 0,
	'File::Basename' => 0,
	'IO::File'       => 0,
	'POSIX'          => 0,
	'Sys::Hostname'  => 0,
    },
    add_to_cleanup     => [ 'Log-LTSV-*' ],
    create_makefile_pl => 'traditional',
);

$builder->create_build_script();
