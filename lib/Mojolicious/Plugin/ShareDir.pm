package Mojolicious::Plugin::ShareDir;
use Mojo::Base 'Mojolicious::Plugin';

our $VERSION = '0.01';

use File::ShareDir;

sub register {
    my ( $self, $app ) = @_;
}

1;

__END__

=encoding utf-8

=head1 NAME

Mojolicious::Plugin::ShareDir - Use File::ShareDir paths automatically

=head1 SYNOPSIS

    # MyApp.pm
    package MyApp;
    use Mojo::Base 'Mojolicious';

    sub startup {
        my $app = shift;
        $app->plugin( 'ShareDir' );

        # $app->renderer->paths is now set to [ "$share/templates" ]
        # $app->status->paths is now set to [ "$share/public" ]

        my $sharedir = $app->sharedir;         # Returns a Mojo::File obj
    }

=head1 DESCRIPTION

This L<Mojolicious> plugin integrates L<File::ShareDir> with your Mojolicious
app, automatically setting the path to your C<templates> and C<public>
directories, and making it easy to access additonal shared directories and data.
This works seamlessly during development and after installation.

Since this module modifies your renderer and static paths, make sure to load it
early!

This plugin is heavily inspired by and very similar to
L<Mojolicious::Plugin::InstallablePaths>, but supports a slightly different
directory structure.

=head1 DIRECTORY STRUCTURE

This script assumes a fairly standard Mojolicious application layout. If your
app starts out like this:

    my_app
    |- Makefile.PL
    |- lib/
    |- myapp.conf
    |- public/
    |- script/
    |- t/
    +- templates/

Create a new C<share/> directory, and move your C<templates> and C<public>
directories into it. You should now have a structure like this:

    my_app
    |- Makefile.PL
    |- lib/
    |- myapp.conf
    |- script/
    |- share/
    |  |- public/
    |  +- templates/
    +- t/

=head1 BUILD SCRIPTS

You'll need to modify your build system to have your new C<share/> directory
installed along with your application.

=head2 ExtUtils::MakeMaker

This is the default if you used C<mojo generate makefile>).

Use L<File::ShareDir::Install> in your C<Makefile.PL>:

    use ExtUtils::MakeMaker;
    use File::ShareDir::Install;

    install_share 'share';

    WriteMakefile( ... );

    package MY;
    use File::ShareDir::Install qw(postamble);

=head2 Other build systems

If you're using L<Module::Install>, take a look at L<Module::Install::Share>.

If you're using L<Dist::Zilla>, take a look at L<Dist::Zill::Plugin::ShareDir>.

If you're using something else, check your build system's documentation and/or
search CPAN for how to have the share directory installed along with your
application.

=head1 CONFIGURATION

None.

=head1 HELPERS

=head2 sharedir

    my $dir = $app->sharedir;
    my $subdir = $app->sharedir->child('data');

Returns a L<Mojo::File> object pointing at your share directory.

=head1 METHODS

L<Mojolicious::Plugin::ShareDir> inherits all methods from
L<Mojolicious::Plugin> and implements the following new ones.

=head2 register

  $plugin->register(Mojolicious->new);

Register plugin in L<Mojolicious> application, updates paths, and adds helpers.

=head1 AUTHOR

Adam Herzog E<lt>adam@adamherzog.comE<gt>

=head1 COPYRIGHT

Copyright 2019 Adam Herzog

=head1 LICENSE

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=head1 SEE ALSO

L<Mojolicious>, L<Mojolicious::Guides>, L<File::ShareDir>.
