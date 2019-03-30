# NAME

Mojolicious::Plugin::ShareDir - Use File::ShareDir paths automatically

# SYNOPSIS

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

# DESCRIPTION

This [Mojolicious](https://metacpan.org/pod/Mojolicious) plugin integrates [File::ShareDir](https://metacpan.org/pod/File::ShareDir) with your Mojolicious
app, automatically setting the path to your `templates` and `public`
directories, and making it easy to access additonal shared directories and data.
This works seamlessly during development and after installation.

Since this module modifies your renderer and static paths, make sure to load it
early!

This plugin is heavily inspired by and very similar to
[Mojolicious::Plugin::InstallablePaths](https://metacpan.org/pod/Mojolicious::Plugin::InstallablePaths), but supports a slightly different
directory structure.

# DIRECTORY STRUCTURE

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

Create a new `share/` directory, and move your `templates` and `public`
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

# BUILD SCRIPTS

You'll need to modify your build system to have your new `share/` directory
installed along with your application.

## ExtUtils::MakeMaker

This is the default if you used `mojo generate makefile`).

Use [File::ShareDir::Install](https://metacpan.org/pod/File::ShareDir::Install) in your `Makefile.PL`:

    use ExtUtils::MakeMaker;
    use File::ShareDir::Install;

    install_share 'share';

    WriteMakefile( ... );

    package MY;
    use File::ShareDir::Install qw(postamble);

## Other build systems

If you're using [Module::Install](https://metacpan.org/pod/Module::Install), take a look at [Module::Install::Share](https://metacpan.org/pod/Module::Install::Share).

If you're using [Dist::Zilla](https://metacpan.org/pod/Dist::Zilla), take a look at [Dist::Zill::Plugin::ShareDir](https://metacpan.org/pod/Dist::Zill::Plugin::ShareDir).

If you're using something else, check your build system's documentation and/or
search CPAN for how to have the share directory installed along with your
application.

# CONFIGURATION

None.

# HELPERS

## sharedir

    my $dir = $app->sharedir;
    my $subdir = $app->sharedir->child('data');

Returns a [Mojo::File](https://metacpan.org/pod/Mojo::File) object pointing at your share directory.

# METHODS

[Mojolicious::Plugin::ShareDir](https://metacpan.org/pod/Mojolicious::Plugin::ShareDir) inherits all methods from
[Mojolicious::Plugin](https://metacpan.org/pod/Mojolicious::Plugin) and implements the following new ones.

## register

    $plugin->register(Mojolicious->new);

Register plugin in [Mojolicious](https://metacpan.org/pod/Mojolicious) application, updates paths, and adds helpers.

# AUTHOR

Adam Herzog <adam@adamherzog.com>

# COPYRIGHT

Copyright 2019 Adam Herzog

# LICENSE

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

# SEE ALSO

[Mojolicious](https://metacpan.org/pod/Mojolicious), [Mojolicious::Guides](https://metacpan.org/pod/Mojolicious::Guides), [File::ShareDir](https://metacpan.org/pod/File::ShareDir).
