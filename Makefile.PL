use 5.000;
use ExtUtils::MakeMaker;

WriteMakefile(
    NAME         => 'HTML::Menu::DateTime',
    VERSION_FROM => 'DateTime.pm',
    PREREQ_PM    => {
                     Carp       => 0,
                     Test::More => 0,
    },
);

