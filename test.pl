#!/usr/bin/perl
use PerlIO::via::trap ('open');
use Template;

package fnord;

sub test {
    my $mode = shift;
    local *FH;
    open (FH, $mode, "testout.fnord") or die $!;
    warn "fh is ".\*FH;
    print FH "fnord\n";
    close FH;
}

package main;

$PerlIO::via::trap::PASS = 1;
fnord::test('>');
$PerlIO::via::trap::PASS = 0;

eval { fnord::test('+<') } or warn $@;

open my $fh, "+<testout.fnord";

warn "fh is ".$fh;
#undef $/;
while (<$fh>) {
    print "> $_";
}
