my $config = {
    'Model::DB' => {
        connect_info => {
            dsn            => 'dbi:SQLite:dbname=__HOME__/veganbook.db',
            sqlite_unicode => 1,
        },
    },
};
return $config;
