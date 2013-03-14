package VeganBook::Util;
use strict;
use warnings;
use 5.010;
use Config::JFDI;
use Dir::Self;
use VeganBook::Schema;

sub get_config {
    my $home = __DIR__ . '/../..';
    my $jfdi = Config::JFDI->new(
        name => "VeganBook",
        path => $home,
    );
    my $config = $jfdi->get;
    return $config;
}

sub get_schema {
    my $config = get_config();
    my $schema =
      VeganBook::Schema->connect($config->{'Model::DB'}{connect_info})
      or die "Unable to connect\n";

    return $schema;
}
1;

