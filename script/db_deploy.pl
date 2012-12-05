#!/usr/bin/env perl

use strict;
use warnings;
use 5.010;

use FindBin qw/$Bin/;
use lib "$Bin/../lib";
use VeganBook::Schema;

my $schema = VeganBook::Schema->connect(
            "dbi:SQLite:dbname=$Bin/../veganbook.db"
    ) or die "Unable to connect\n";


say "Enter 'Y' to deploy the schema. This will delete all data in veganbook.db";
my $ui = <>;
chomp $ui;

if ($ui eq 'Y') {
    $schema->deploy({ add_drop_table => 1 });
}
else {
    say "schema deployment aborted.";
    exit;
}
