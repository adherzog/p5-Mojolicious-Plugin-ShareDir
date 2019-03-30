use Mojo::Base -strict;
use Test::More;
use Test::Mojo;

{
    package MyApp;
    use Mojolicious::Lite;

    plugin 'ShareDir';

    get '/' => sub {
        my $c = shift;
        $c->render( text => 'Hello Mojo!' );
    };
}

my $t = Test::Mojo->new('MyApp');
$t->get_ok('/')->status_is(200)->content_is('Hello Mojo!');

done_testing();
