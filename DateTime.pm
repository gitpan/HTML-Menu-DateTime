package HTML::Menu::DateTime;
use strict;
use Carp;

our $VERSION = '0.91_01';


sub new {
  my $pkg = shift;
  my $date;
  
  if (@_ == 1 ) {
    $date = shift;
  }
  
  my ($SEC, $MIN, $HOUR, $DAY, $MONTH, $YEAR) = (localtime(time))[0..5];
  $MONTH += 1;
  $YEAR  += 1900;
  
  # setup defaults, then override with input (if any)
  my $self = bless ({second       => $SEC,
                     minute       => $MIN,
                     hour         => $HOUR,
                     day          => $DAY,
                     month        => $MONTH,
                     year         => $YEAR,
                     date         => $date,
                     less_years   => 5,
                     plus_years   => 5,
                     month_format => 'long',
                     @_,
                    }, $pkg);
  
  
  if ($self->{date}) {
    if ($self->{date} =~ /^([0-9]{4})-([0-9]{2})-([0-9]{2})$/) {
      # YYYY-MM-DD
      $self->{year}   = $1;
      $self->{month}  = $2;
      $self->{day}    = $3;
      $self->{hour}   = 0;
      $self->{minute} = 0;
      $self->{second} = 0;
    }
    elsif ($self->{date} =~ 
      /^([0-9]{4})-([0-9]{2})-([0-9]{2}) ([0-9]{2}):([0-9]{2}):([0-9]{2})$/) 
    {
      # YYYY-MM-DD hh:mm:ss
      $self->{year}   = $1;
      $self->{month}  = $2;
      $self->{day}    = $3;
      $self->{hour}   = $4;
      $self->{minute} = $5;
      $self->{second} = $6;
    }
    elsif ($self->{date} =~ /^([0-9]{4})$/) {
      # YYYY
      $self->{year}   = $1;
      $self->{month}  = 0;
      $self->{day}    = 0;
      $self->{hour}   = 0;
      $self->{minute} = 0;
      $self->{second} = 0;
    }
    elsif ($self->{date} =~ /^([0-9]{4})([0-9]{2})$/) {
      # YYYYMM
      $self->{year}   = $1;
      $self->{month}  = $2;
      $self->{day}    = 0;
      $self->{hour}   = 0;
      $self->{minute} = 0;
      $self->{second} = 0;
    }
    elsif ($self->{date} =~ /^([0-9]{4})([0-9]{2})([0-9]{2})$/) {
      # YYYYMMDD
      $self->{year}   = $1;
      $self->{month}  = $2;
      $self->{day}    = $3;
      $self->{hour}   = 0;
      $self->{minute} = 0;
      $self->{second} = 0;
    }
    elsif ($self->{date} =~ /^([0-9]{4})([0-9]{2})([0-9]{2})([0-9]{2})$/) {
      # YYYYMMDDhh
      $self->{year}   = $1;
      $self->{month}  = $2;
      $self->{day}    = $3;
      $self->{hour}   = $4;
      $self->{minute} = 0;
      $self->{second} = 0;
    }
    elsif ($self->{date} =~ 
      /^([0-9]{4})([0-9]{2})([0-9]{2})([0-9]{2})([0-9]{2})$/) 
    {
      # YYYYMMDDhhmm
      $self->{year}   = $1;
      $self->{month}  = $2;
      $self->{day}    = $3;
      $self->{hour}   = $4;
      $self->{minute} = $5;
      $self->{second} = 0;
    }
    elsif ($self->{date} =~ 
      /^([0-9]{4})([0-9]{2})([0-9]{2})([0-9]{2})([0-9]{2})([0-9]{2})$/) 
    {
      # YYYYMMDDhhmmss
      $self->{year}   = $1;
      $self->{month}  = $2;
      $self->{day}    = $3;
      $self->{hour}   = $4;
      $self->{minute} = $5;
      $self->{second} = $6;
    }
    elsif ($self->{date} =~ /^([0-9]{2}):([0-9]{2}):([0-9]{2})$/) {
      # hh:mm:ss
      $self->{year}   = 0;
      $self->{month}  = 0;
      $self->{day}    = 0;
      $self->{hour}   = $1;
      $self->{minute} = $2;
      $self->{second} = $3;
    }
    else {croak("invalid 'date' format");}
  }
  
  return $self;
}


sub second_menu {
  my $self   = shift;
  my $select = _parse_input ($self->{second}, @_);
  
  my @loop;
  
  if (defined $self->{empty_first}) {
    push @loop, {value => '', label => $self->{empty_first}};
  }
  
  for my $item ('00'..'09',10..59) {
    my %data = (
      value => $item,
      label => $item,
    );
    if (! $self->{no_select} && (grep {$_ == $item} @$select)) {
      $data{selected} = ' selected ';
    }
    push @loop, \%data;
  }

  return \@loop;
}


sub minute_menu {
  my $self   = shift;
  my $select = _parse_input ($self->{minute}, @_);
  
  my @loop;
  
  if (defined $self->{empty_first}) {
    push @loop, {value => '', label => $self->{empty_first}};
  }
  
  for my $item ('00'..'09',10..59) {
    my %data = (
      value => $item,
      label => $item,
    );
    if (! $self->{no_select} && (grep {$_ == $item} @$select)) {
      $data{selected} = ' selected ';
    }
    push @loop, \%data;
  }

  return \@loop;
}


sub hour_menu {
  my $self   = shift;
  my $select = _parse_input ($self->{hour}, @_);
  
  my @loop;
  
  if (defined $self->{empty_first}) {
    push @loop, {value => '', label => $self->{empty_first}};
  }
  
  for my $item ('00'..'09',10..23) {
    my %data = (
      value => $item,
      label => $item,
    );
    if (! $self->{no_select} && (grep {$_ == $item} @$select)) {
      $data{selected} = ' selected ';
    }
    push @loop, \%data;
  }

  return \@loop;
}


sub day_menu {
  my $self   = shift;
  my $select = _parse_input ($self->{day}, @_);
  
  my @loop;
  
  if (defined $self->{empty_first}) {
    push @loop, {value => '', label => $self->{empty_first}};
  }
  
  for my $item ('01'..'09', 10..31) {
    my %data = (
      value => $item,
      label => $item,
    );
    if (! $self->{no_select} && (grep {$_ == $item} @$select)) {
      $data{selected} = ' selected ';
    }
    push @loop, \%data;
  }

  return \@loop;
}


sub month_menu {
  my $self   = shift;
  my $select = _parse_input ($self->{month}, @_);
  
  my @decimal = ('01'..'09', 10..12);
  
  my %mon;
  if ($self->{month_format} eq 'decimal') {
    @mon{@decimal} = @decimal;
  }
  elsif ($self->{month_format} eq 'short') {
    @mon{@decimal} = qw/Jan Feb Mar Apr May Jun Jul Aug Sep Oct Nov Dec/;
  }
  elsif ($self->{month_format} eq 'ornate') {
    @mon{@decimal} = qw/1st 2nd 3rd 4th 5th 6th 7th 8th 9th 10th 11th 12th/;
  }
  else {
    @mon{@decimal} = qw/January February March April May June July August 
                        September October November December/;
  }
  
  my @loop;
  if (defined $self->{empty_first}) {
    push @loop, {value => '', label => $self->{empty_first}};
  }
  
  for my $item (sort {$a <=> $b} keys %mon) {
    my %data = (
      value => $item,
      label => $mon{$item},
    );
    if (! $self->{no_select} && (grep {$_ == $item} @$select)) {
      $data{selected} = ' selected ';
    }
    push @loop, \%data;
  }

  return \@loop;
}


sub year_menu {
  my $self   = shift;
  my $select = _parse_input ($self->{year}, @_);
  my $single = @$select == 1 ? $select->[0] : undef;
  
  croak('selected year must be above 0') unless $select > 0;
  
  my ($start, $end);
  
  if (defined $self->{start_year} ) {
    $start = $self->{start_year};
    
    croak('start_year cannot be after selected year') 
      if grep {$_ < $start} @$select;
  }
  else {
    croak('cannot use less_years with multiple selections')
      if ! $single;
    
    $start = $single - $self->{less_years};
  }
  
  croak('start year must be above 0') unless $start > 0;
  
  if (defined $self->{end_year} ) {
    $end = $self->{end_year};
    croak('end_year cannot be before selected year') 
      if grep {$_ > $end} @$select;
  }
  else {
    croak('cannot use plus_years with multiple selections') 
      if ! $single;
    
    $end = $single + $self->{plus_years};
  }
  
  croak('end year must be after start year') if $start > $end;
  
  my @years = ( $start .. $end );
  my @loop;
  
  if (defined $self->{empty_first}) {
    push @loop, {value => '', label => $self->{empty_first}};
  }
  
  for my $item (@years) {
    my %data = (
      value => $item,
      label => $item,
    );
    if (! $self->{no_select} && (grep {$_ == $item} @$select)) {
      $data{selected} = ' selected ';
    }
    push @loop, \%data;
  }

  return \@loop;
}

#####

sub start_year {
  my $self = shift;

  $self->{start_year} = defined $_[0] ? shift : undef;
}


sub end_year {
  my $self = shift;

  $self->{end_year} = defined $_[0] ? shift : undef;
}


sub less_years {
  my $self = shift;

  $self->{less_years} = defined $_[0] ? shift : undef;
}


sub plus_years {
  my $self = shift;

  $self->{plus_years} = defined $_[0] ? shift : undef;
}


sub month_format {
  my $self = shift;

  $self->{month_format} = defined $_[0] ? shift : 'long';
}

###

sub _parse_input {
  my ($time, $i) = @_;
  my @val;
  
  return [$time] unless defined $i;
  
  if (ref($i) eq 'ARRAY') {
    @val = grep {/^\d+$/} @$i;
  }
  elsif ($i =~ /^\d+$/) {
    push @val, $i;
  }
  elsif ($i =~ /^\+(\d+)$/) {
    push @val, $time + $1;
  }
  elsif ($i =~ /^\-(\d+)$/) {
    push @val, $time - $1;
  }
  else {
    croak('invalid input at _parse_input()');
  }
  
  return \@val;
}

1;


=head1 NAME

HTML::Menu::DateTime - Easily create HTML select menus for use with the 
HTML::Template or Template::Toolkit templating systems.

=head1 SYNOPSIS

  use HTML::Menu::DateTime;
  
  my $menu = HTML::Menu::DateTime->new (
    date         => '2004-02-26',
    no_select    => 1,
    empty_first  => '',
    month_format => 'short');
  
  $menu->start_year (2000);
  $menu->end_year (2010);
  
  $menu->less_years (1);
  $menu->plus_years (5);
  
  $menu->month_format ('short');
  
  $menu->second_menu;
  $menu->minute_menu;
  $menu->hour_menu;
  $menu->day_menu;
  $menu->month_menu;
  $menu->year_menu;

=head1 DESCRIPTION

Creates data structures suitable for populating HTML::Template or 
Template::Toolkit templates with dropdown date and time menus.

Allows any number of dropdown menus to be displayed on a single page, each 
independantly configurable.

Distribution includes ready-to-use template include files.

=head1 MOTIVATION

To keep the creation of HTML completely seperate from the program, to easily 
allow a non-programmer to add css styles, javascript, etc. to individual 
menus.

To make the creation of menus as simple as possible, with extra options if 
needed. Menus can be created as easily as:

  my $template = HTML::Template->new (filename => $filename);
  
  my $menu = HTML::Menu::DateTime->new;
  
  $template->param (day   => $menu->day_menu,
                    month => $menu->month_menu,
                    year  => $menu->year_menu);
  
  print $template->output;

=head1 METHODS

=head2 new()

  my $menu1 = HTML::Menu::DateTime->new 
                (date        => $date,
                 start_year  => $start,
                 end_year    => $end,
                 no_select   => 1,
                 empty_first => 1);
  
  my $menu2 = HTML::Menu::DateTime->new 
                (less_years => $less,
                 plus_years => $plus);

C<new()> accepts the following arguments:

=over

=item date

Can be in any of the formats 'YYYY-MM-DD hh:mm:ss', 'YYYYMMDDhhmmss', 
'YYYYMMDDhhmm', 'YYYYMMDDhh', 'YYYYMMDD', 'YYYYMM', 'YYYY', 'YYYY-MM--DD', 
'hh:mm:ss'.

The date passed to C<new()> is used to decide which item should be selected 
in all of the menu methods.

=item start_year

Accepts the same values as the start_year method.

=item end_year

Accepts the same values as the end_year method.

=item less_years

Accepts the same values as the less_years method.

=item plus_years

Accepts the same values as the plus_years method.

=item no_select

If true, ensures no item in any menu will be selected. (Otherwise, the current 
date and time will be used).

=item empty_first

If defined, will create an extra list item at the start of each menu. The 
form value will be the empty string (''), the value passed to 
C<empty_first('value')> will be the visible label for the first item (the 
empty string is allowed).

=item month_format

Accepts the same values as the month_format method.

=back

=head2 start_year()

  $date->start_year (2004);

Sets the absolute year that the dropdown menu will start from.

=head2 end_year()

  $date->end_year (2009);

Sets the absolute year that the dropdown menu will end on.

=head2 less_years()

  $date->less_years (2);

Sets the year that the dropdown menu will start from, relative to the selected 
year.

May not be used if multiple values for selection are passed to C<year_menu()>.

=head2 plus_years()

  $date->plus_years (7);

Sets the year that the dropdown menu will end on, relative to the selected 
year.

May not be used if multiple values for selection are passed to C<year_menu()>.

=head2 month_format()

Each item in the month menu has a label. By default this is the long English 
month name, such as 'January', 'February', etc. The format of the label can 
be changed as shown in the list below.

  $date->month_format ('long');      # January, February, ...
  $date->month_format ('short');     # Jan, Feb, ...
  $date->month_format ('decimal');   # 01, 02, ...
  $date->month_format ('ornate');    # 1st, 2nd, ...

=head2 second_menu()

  $date->second_menu;
  $date->second_menu (0);
  $date->second_menu ('+1');
  $date->second_menu ([0, 1]);

Accepts a value that will override the date (if any) in the C<new()> method.

Argurment can be a number (0-59), a value such as '+1' or '-1' (relative to 
either the date passed to C<new()> or the current time) or an arrayref of 
number values.

Passing an arrayref of values will cause more than one item in the menu list 
to be selected. This will require the HTML in the template to be changed so 
that the SELECT menu has a size higher than 1 and the 'multiple' attribute.

  <SELECT name="second" size="2" multiple>

Returns an array-reference suitable for passing directly to 
C<$template->param()>.

=head2 minute_menu()

  $date->minute_menu;
  $date->minute_menu (0);
  $date->minute_menu ('+1');
  $date->minute_menu ([0, 1]);

Accepts a value that will override the date (if any) in the C<new()> method.

Argurment can be a number (0-59), a value such as '+1' or '-1' (relative to 
either the date passed to C<new()> or the current time) or an arrayref of 
number values.

Passing an arrayref of values will cause more than one item in the menu list 
to be selected. This will require the HTML in the template to be changed so 
that the SELECT menu has a size higher than 1 and the 'multiple' attribute.

  <SELECT name="minute" size="2" multiple>

Returns an array-reference suitable for passing directly to 
C<$template->param()>.

=head2 hour_menu()

  $date->hour_menu;
  $date->hour_menu (0);
  $date->hour_menu ('+1');
  $date->hour_menu ([0, 1]);

Accepts a value that will override the date (if any) in the C<new()> method.

Argurment can be a number (0-23), a value such as '+1' or '-1' (relative to 
either the date passed to C<new()> or the current time) or an arrayref of 
number values.

Passing an arrayref of values will cause more than one item in the menu list 
to be selected. This will require the HTML in the template to be changed so 
that the SELECT menu has a size higher than 1 and the 'multiple' attribute.

  <SELECT name="hour" size="2" multiple>

Returns an array-reference suitable for passing directly to 
C<$template->param()>.

=head2 day_menu()

  $date->day_menu;
  $date->day_menu (0);
  $date->day_menu ('+1');
  $date->day_menu ([0, 1]);

Accepts a value that will override the date (if any) in the C<new()> method.

Argurment can be a number (1-31), a value such as '+1' or '-1' (relative to 
either the date passed to C<new()> or the current time) or an arrayref of 
number values.

Passing an arrayref of values will cause more than one item in the menu list 
to be selected. This will require the HTML in the template to be changed so 
that the SELECT menu has a size higher than 1 and the 'multiple' attribute.

  <SELECT name="day" size="2" multiple>

Returns an array-reference suitable for passing directly to 
C<$template->param()>.

=head2 month_menu()

  $date->month_menu;
  $date->month_menu (0);
  $date->month_menu ('+1');
  $date->month_menu ([0, 1]);

Accepts a value that will override the date (if any) in the C<new()> method.

Argurment can be a number (1-12), a value such as '+1' or '-1' (relative to 
either the date passed to C<new()> or the current time) or an arrayref of 
number values.

Passing an arrayref of values will cause more than one item in the menu list 
to be selected. This will require the HTML in the template to be changed so 
that the SELECT menu has a size higher than 1 and the 'multiple' attribute.

  <SELECT name="month" size="2" multiple>

Returns an array-reference suitable for passing directly to 
C<$template->param()>.

=head2 year_menu()

  $date->year_menu;
  $date->year_menu (0);
  $date->year_menu ('+1');
  $date->year_menu ([0, 1]);

Accepts a value that will override the date (if any) in the C<new()> method.

Argurment can be a number (0 or higher), a value such as '+1' or '-1' 
(relative to either the date passed to C<new()> or the current time) or an 
arrayref of number values.

Passing an arrayref of values will cause more than one item in the menu list 
to be selected. This will require the HTML in the template to be changed so 
that the SELECT menu has a size higher than 1 and the 'multiple' attribute.

  <SELECT name="year" size="2" multiple>

Returns an array-reference suitable for passing directly to 
C<$template->param()>.

=head1 EXAMPLES

=head2 HTML::Template

=head3 Templates

The 'examples/html-template' folder in this distribution contains the files 
second.tmpl, minute.tmpl, hour.tmpl, day.tmpl, month.tmpl and year.tmpl. 
Simply copy these files into the folder containing the rest of your templates.

=head3 Displaying date dropdown menus

Contents of template file "date.tmpl":

  <html>
  <body>
    <form method="POST" action="">
      <TMPL_INCLUDE day.tmpl>
      <TMPL_INCLUDE month.tmpl>
      <TMPL_INCLUDE year.tmpl>
      <input type="submit" name="Submit" value="Submit">
    </form>
  </body>
  </html>

Contents of program file:

  #!/usr/bin/perl
  use strict;
  use warnings;
  use CGI ':standard';
  use HTML::Menu::DateTime;
  use HTML::Template;
  
  my $template = HTML::Template->new (filename => 'date.tmpl');
  
  my $menu = HTML::Menu::DateTime->new;
  
  $template->param (day   => $menu->day_menu,
                    month => $menu->month_menu,
                    year  => $menu->year_menu);
  
  print header(),
  print $template->output;

=head3 Multiple Menus in a Single Page

To create, for example, 2 'month' menus in a single page you could copy the 
month.tmpl file to end_month.tmpl and then change the line 
C<<select name="month">> in end_month.tmpl to C<<select name="end_month">>.

Then include both files in your main template:

  <html>
  <body>
    <form method="POST" action="">
      <TMPL_INCLUDE month.tmpl>
      <TMPL_INCLUDE end_month.tmpl>
      <input type="submit" name="Submit" value="Submit">
    </form>
  </body>
  </html>

When this form is submitted, it will send 2 different values, 'month' and 
'end_month'.

=head2 Template::Toolkit

=head3 Templates

The 'examples/template-toolkit' folder in this distribution contains the files 
second.html, minute.html, hour.html, day.html, month.html and year.html. 
Simply copy these files into the folder containing the rest of your templates.

=head3 Displaying date dropdown menus

Contents of template file "date.html":

  <html>
  <body>
    <form method="POST" action="">
      [% INCLUDE day.html %]
      [% INCLUDE month.html %]
      [% INCLUDE year.html %]
      <input type="submit" name="Submit" value="Submit">
    </form>
  </body>
  </html>

Contents of program file:

  #!/usr/bin/perl
  use strict;
  use warnings;
  use CGI ':standard';
  use HTML::Menu::DateTime;
  use Template;
  
  my $template = Template->new;
  
  my $menu = HTML::Menu::DateTime->new;
  
  my $vars = {day   => $menu->day_menu,
              month => $menu->month_menu,
              year  => $menu->year_menu};
  
  $template->process ('date.html', $vars) 
    or die $template->error;

=head3 Multiple Menus in a Single Page

To create, for example, 2 'month' menus in a single page you could copy the 
month.tmpl file to end_month.tmpl and then change the line 
C<<select name="month">> in end_month.tmpl to C<<select name="end_month">>.

Then include both files in your main template:

  <html>
  <body>
    <form method="POST" action="">
      [% INCLUDE month.html %]
      [% INCLUDE end_month.html %]
      <input type="submit" name="Submit" value="Submit">
    </form>
  </body>
  </html>

When this form is submitted, it will send 2 different values, 'month' and 
'end_month'.

=head1 DEFAULT VALUES

If a date is not passed to the C<new()> or menu methods, then 
C<localtime(time)> is called.

If neither 'start_year' or 'less_years' is set, the default used is 
C<less_years(5)>.

If neither 'end_year' or 'plus_years' is set, the default used is 
C<plus_years(5)>.

=head1 EXPORT

None.

=head1 TIPS

Years before 1000 AD passed to the C<new()> method in the 'YYYYMMDDhhmmss' 
format should be passed as strings, as the leading zeros are necessary. (e.g. 
'09990101000000'). (Years before 1000 AD may be passed to the C<year_menu()> 
method as literal numbers.)

Years before 1 AD are not allowed at all.

DO NOT set both 'start_year' and 'less_years' at the same time, it just 
doesn't make sense.

DO NOT set both with 'end_year' and 'plus_years' at the same time, it just 
doesn't make sense.

To start or end the range on the same year as selected, set less_years or 
plus_years to zero, DO NOT set start_year or end_year to zero.

When settting either 'start_year' or 'end_year', ensure that the selected year 
will fall within the range of years.

When passing relative values to methods, ensure they are sent as strings. 
C<+1> numerically means C<1> which is not the same as the string C<'+1'>.

If a date is set in C<new()> and either 'less_years' or 'plus_years' set and 
then a value passed to the c<year_menu()> method. The start / end year of the 
menu will be relative to the value passed to C<year_menu()>, not the date set 
in C<new()>.

'Relative' parameter values sent to menu methods, which result in 
out-of-range selections are silently ignored and no item in the output menu 
will be selected.

=head1 TO DO

Add options to allow 'short' month names to be output, month numbers to be 
output, or other language month names to be output.

Add option to output html/xhtml menus rather than data structures for 
templates.

May change C<year_menu()> such that less_years / plus_years works with 
multiple selections - it would probably have to start / end the list in 
relation to the lowest / highest year.

=head1 SUPPORT / BUGS

Please log bugs, feature requests and patch submissions at 
L<http://sourceforge.net/projects/html-menu>.

Support mailing list: html-menu-users@lists.sourceforge.net

=head1 SEE ALSO

L<HTML::Template>, L<Template::Toolkit>.

=head1 AUTHOR

Carl Franks

=head1 COPYRIGHT AND LICENSE

Copyright 2004, Carl Franks.  All rights reserved.  

This library is free software; you can redistribute it and/or modify it under 
the same terms as Perl itself (L<perlgpl>, L<perlartistic>).

=cut

