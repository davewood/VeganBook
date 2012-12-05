package VeganBook::Schema::Result::Recipe;
use strict;
use warnings;
use base qw/DBIx::Class/;

__PACKAGE__->load_components(qw/ TimeStamp Core /);
__PACKAGE__->table('recipes');
__PACKAGE__->add_columns(
    id => {
        data_type         => 'int',
        is_numeric        => 1,
        is_auto_increment => 1
    },
    name   => { data_type => 'varchar', is_nullable => 0 },
    content => { data_type => 'varchar', is_nullable => 0 },
    created => { data_type => 'timestamp', set_on_create => 1 },
    updated => { data_type => 'timestamp', set_on_create => 1, set_on_update => 1 },
);

__PACKAGE__->set_primary_key('id');
__PACKAGE__->resultset_attributes({ order_by => 'updated' });

__PACKAGE__->has_many(
    'recipe_ingredients',
    'VeganBook::Schema::Result::RecipeIngredient',
    'recipe_id',
);

__PACKAGE__->many_to_many(
    'ingredients',
    'recipe_ingredients',
    'ingredient'
);

1;
