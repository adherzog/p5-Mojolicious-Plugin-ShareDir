requires 'perl', '5.008005';

requires 'File::ShareDir';
requires 'Mojolicious';

on test => sub {
    requires 'Test::More', '0.96';
};
