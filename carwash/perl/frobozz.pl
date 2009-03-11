#!/usr/bin/perl

# jhannah
# Omaha Perl Mongers: http://omaha.pm.org
# $Id: frobozz.pl 3 2007-08-08 12:58:54Z  $

use strict;
use Term::InKey;
use FileHandle;
STDOUT->autoflush();

# Slap your products in here (up to 9 of them)...
my $tmp = <<EOT;
Simple       5    Wash
Clean        6    Wash,Soak
Stupendous   7    Wash,Soak,Wax
EOT

# Thanks, simple human. Now Perl will do the dirty work,
# building the structures we'll need to get the job done.
my ($products, @products, $product_choices);
foreach my $line (split /\n/, $tmp) {
   my ($product, $cost, $actions) = split / +/, $line;
   push @products, $product;
   my $cnt = @products;
   $products->[ $cnt ] = {
      cost    => $cost,
      actions => $actions
   };
   $product_choices .= "  [$cnt] Buy $product (\$$cost)\n";
}

my $balance = 0;
my $message;
while (1) {
   &Clear;
   choices();
   print "> ";
   for (my $x = &ReadKey) {
      /i/  && do { dollar_inserted() };
      /q/  && do { exit };
      /\d/ && do { purchase($x) };
      next;
   }
}

# END MAIN

sub dollar_inserted {
   $balance++;
   $message = "Cha-ching!";
}

sub purchase {
   my ($product) = @_;
   my $amount = $products->[$product]->{cost};
   my $actions = $products->[$product]->{actions};
   return unless $amount;
   if ($balance < $amount) {
      $message = "Please insert more money first.";
      return;
   }
   $balance -= $amount;
   $message = "You just bought $actions for $amount dollars.";
}

sub choices {
   print <<EOT;

$message

Your balance: $balance

  [i] Insert dollar

$product_choices
  [q] Quit

EOT
   undef $message;
}


