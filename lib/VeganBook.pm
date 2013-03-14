package VeganBook;
use Moose;
use namespace::autoclean;

use Catalyst::Runtime 5.80;

# Set flags and add plugins for the application.
#
# Note that ORDERING IS IMPORTANT here as plugins are initialized in order,
# therefore you almost certainly want to keep ConfigLoader at the head of the
# list if you're using it.
#
#         -Debug: activates the debug mode for very useful log messages
#   ConfigLoader: will load the configuration from a Config::General file in the
#                 application's home directory
# Static::Simple: will serve static files from the application's root
#                 directory

use Catalyst qw/
    ConfigLoader
    Static::Simple
    Unicode::Encoding
    +CatalystX::Resource
    Session
    Session::Store::FastMmap
    Session::State::Cookie
    StackTrace
/;

extends 'Catalyst';

our $VERSION = '0.01';

# Configure the application.
#
# Note that settings in veganbook.conf (or other external
# configuration file that you set up manually) take precedence
# over this when using ConfigLoader. Thus configuration
# details given here can function as a default configuration,
# with an external configuration file acting as an override for
# local deployment.

__PACKAGE__->config(
    name => 'VeganBook',
    # Disable deprecated behavior needed by old applications
    disable_component_resolution_regex_fallback => 1,
    enable_catalyst_header => 1, # Send X-Catalyst header
    'Plugin::Session' => { flash_to_stash => 1 },
    'View::HTML' => {
        INCLUDE_PATH => [
            __PACKAGE__->path_to( qw/ root templates / ),
        ],
        WRAPPER => 'wrapper.tt',
        ENCODING => 'utf-8',
    },
    'Model::DB' => {
        schema_class => 'VeganBook::Schema',
    },
    'CatalystX::Resource' => {
        controllers => [qw/
            Recipe
            Ingredient
        /]
    },
    'Controller::Recipe' => {
        resultset_key          => 'recipes_rs',
        resources_key          => 'recipes',
        resource_key           => 'recipe',
        form_class             => 'VeganBook::Form::Recipe',
        model                  => 'DB::Recipe',
        redirect_mode          => 'list',
        actions                => {
            base => {
                Chained => '/',
                PathPart => 'recipe',
            },
        },
    },
    'Controller::Ingredient' => {
        resultset_key          => 'ingredients_rs',
        resources_key          => 'ingredients',
        resource_key           => 'ingredient',
        form_class             => 'VeganBook::Form::Ingredient',
        model                  => 'DB::Ingredient',
        redirect_mode          => 'list',
        actions                => {
            base => {
                Chained => '/',
                PathPart => 'ingredient',
            },
        },
    },
);

# Start the application
__PACKAGE__->setup();


=head1 NAME

VeganBook - Catalyst based application

=head1 SYNOPSIS

    script/veganbook_server.pl

=head1 DESCRIPTION

[enter your description here]

=head1 SEE ALSO

L<VeganBook::Controller::Root>, L<Catalyst>

=head1 AUTHOR

David Schmidt,,,

=head1 LICENSE

This library is free software. You can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

1;
