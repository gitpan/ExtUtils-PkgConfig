#!/usr/bin/perl
#
# $Header: /cvsroot/gtk2-perl/gtk2-perl-xs/ExtUtils-PkgConfig/t/2.t,v 1.3 2008/02/09 19:31:16 kaffeetisch Exp $
#

use strict;
use warnings;

use Test::More tests => 11;
use ExtUtils::PkgConfig;

$ENV{PKG_CONFIG_PATH} = './t/';

my ($major, $minor) = split /\./, `pkg-config --version`; # Ignore micro part
diag ("Testing pkg-config $major.$minor");

cmd_ok ('modversion');
cmd_ok ('cflags');
cmd_ok ('cflags-only-I');
cmd_ok ('libs');
cmd_ok ('libs-only-L');
cmd_ok ('libs-only-l');

SKIP: {
  skip '*-only-other', 2
    unless ($major > 0 || $minor >= 15);

  cmd_ok ('cflags-only-other');
  cmd_ok ('libs-only-other');
}

SKIP: {
  skip 'static libs', 1
    unless ($major > 0 || $minor >= 18);

  my $data = ExtUtils::PkgConfig->static_libs(qw/test_glib-2.0/);
  like ($data, qr/pthread/);
}

my $data;

$data = ExtUtils::PkgConfig->variable(qw/test_glib-2.0/, 'glib_genmarshal');
ok (defined $data);

$data = ExtUtils::PkgConfig->variable(qw/test_glib-2.0/, '__bad__');
ok (not defined $data);

sub cmd_ok {
  my ($cmd, $desc) = @_;

  my $data = ExtUtils::PkgConfig->$cmd(qw/test_glib-2.0/);
  ok (defined $data, $desc);
}
