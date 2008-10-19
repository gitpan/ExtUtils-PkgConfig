#
# $Id: 3.t,v 1.3 2008/10/19 11:54:45 kaffeetisch Exp $
#

use strict;
use warnings;

use Test::More tests => 6;
use ExtUtils::PkgConfig;

$ENV{PKG_CONFIG_PATH} = './t/';

ok( ExtUtils::PkgConfig->atleast_version(qw/test_glib-2.0/, '2.2.0') );
ok( not ExtUtils::PkgConfig->atleast_version(qw/test_glib-2.0/, '2.3.0') );

ok( ExtUtils::PkgConfig->exact_version(qw/test_glib-2.0/, '2.2.3') );
ok( not ExtUtils::PkgConfig->exact_version(qw/test_glib-2.0/, '2.3.0') );

ok( ExtUtils::PkgConfig->max_version(qw/test_glib-2.0/, '2.3.0') );
ok( not ExtUtils::PkgConfig->max_version(qw/test_glib-2.0/, '2.1.0') );
