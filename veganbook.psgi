use strict;
use warnings;

use VeganBook;

my $app = VeganBook->apply_default_middlewares(VeganBook->psgi_app);
$app;

