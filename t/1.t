#
# $Header: /cvsroot/gtk2-perl/gtk2-perl-xs/ExtUtils-PkgConfig/t/1.t,v 1.1 2003/09/16 04:28:42 muppetman Exp $
#

use strict;
use warnings;

#########################

use Test::More tests => 7;
BEGIN { use_ok('ExtUtils::PkgConfig') };

#########################


my %pkg;

# test 1 for success
eval { %pkg = ExtUtils::PkgConfig->find(qw/glib-2.0/); };
ok( not $@ );
ok( $pkg{modversion} and $pkg{cflags} and $pkg{libs} );

# test 1 for failure
eval { %pkg = ExtUtils::PkgConfig->find(qw/bad1/); };
ok( $@ );

# test 2 for success
eval { %pkg = ExtUtils::PkgConfig->find(qw/bad1 glib-2.0/); };
ok( not $@ );
ok( $pkg{modversion} and $pkg{cflags} and $pkg{libs} );

# test 2 for failure
eval { %pkg = ExtUtils::PkgConfig->find(qw/bad1 bad2/); };
ok( $@ );

