package VeganBook::Schema::Result::RecipeIngredient;
use strict;
use warnings;
use base 'DBIx::Class';

__PACKAGE__->load_components(qw/ Core /);

__PACKAGE__->table('recipe_ingredients');
__PACKAGE__->add_columns(
    'id',
    {
        data_type => 'integer',
        is_auto_increment => 1,
        is_numeric => 1,
    },
    'recipe_id',
    {
        data_type => 'integer',
        is_numeric => 1,
    },
    'ingredient_id',
    {
        data_type => 'integer',
        is_numeric => 1,
    },
);

__PACKAGE__->set_primary_key('id');
__PACKAGE__->add_unique_constraint( [qw/recipe_id ingredient_id/] );

__PACKAGE__->belongs_to(
    'recipe',
    'VeganBook::Schema::Result::Recipe',
    'recipe_id'
);

__PACKAGE__->belongs_to(
    'ingredient',
    'VeganBook::Schema::Result::Ingredient',
    'ingredient_id'
);

1;
