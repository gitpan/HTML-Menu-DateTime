use strict;
use Test::More tests => 13;

BEGIN {
	use_ok('HTML::Menu::DateTime');
}

my $ds = HTML::Menu::DateTime->new (
  second_increment => 30,
  );


my $m1 = $ds->second_menu;

ok( @$m1 == 2 , 'correct number of seconds');
ok( ${$m1}[0]->{label} eq '00' , 'correct second label');
ok( ${$m1}[1]->{label} eq '30' , 'correct second label');


$ds->second_increment (5);

my $m2 = $ds->second_menu;

ok( @$m2 == 12 , 'correct number of seconds');
ok( ${$m2}[0]->{label} eq '00' , 'correct second label');
ok( ${$m2}[11]->{label} eq '55' , 'correct second label');


$ds->second_increment (10);

my $m3 = $ds->second_menu;

ok( @$m3 == 6 , 'correct number of seconds');
ok( ${$m3}[0]->{label} eq '00' , 'correct second label');
ok( ${$m3}[5]->{label} eq '50' , 'correct second label');


$ds->second_increment (15);

my $m4 = $ds->second_menu;

ok( @$m4 == 4 , 'correct number of seconds');
ok( ${$m4}[0]->{label} eq '00' , 'correct second label');
ok( ${$m4}[3]->{label} eq '45' , 'correct second label');
