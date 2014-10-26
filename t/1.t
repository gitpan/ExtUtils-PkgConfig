#
# $Header: /cvsroot/gtk2-perl/gtk2-perl-xs/ExtUtils-PkgConfig/t/1.t,v 1.3 2008/01/20 21:05:17 kaffeetisch Exp $
#

use strict;
use warnings;

#########################

use Test::More tests => 7;
BEGIN { use_ok('ExtUtils::PkgConfig') };

require 't/swallow_stderr.inc';

#########################

$ENV{PKG_CONFIG_PATH} = './t/';

my %pkg;

# test 1 for success
eval { %pkg = ExtUtils::PkgConfig->find(qw/test_glib-2.0/); };
ok( not $@ );
ok( $pkg{modversion} and $pkg{cflags} and $pkg{libs} );

# test 1 for failure
swallow_stderr (sub {
	eval { %pkg = ExtUtils::PkgConfig->find(qw/bad1/); };
	ok( $@ );
});

# test 2 for success
eval { %pkg = ExtUtils::PkgConfig->find(qw/bad1 test_glib-2.0/); };
ok( not $@ );
ok( $pkg{modversion} and $pkg{cflags} and $pkg{libs} );

# test 2 for failure
swallow_stderr (sub {
	eval { %pkg = ExtUtils::PkgConfig->find(qw/bad1 bad2/); };
	ok( $@ );
});
