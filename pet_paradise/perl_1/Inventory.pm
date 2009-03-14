package Inventory;

# An object tracking our inventory and who has it reserved. 

my $MAX_SMALL_CAGES = 4;
my $MAX_LARGE_CAGES = 3;


sub new {
   my $self = {
      20090615 => {
         SMALL => {
            1 => [ 7 ],           # Cage_number => [ pet_id ]
            2 => [ 14 ],
         },
         LARGE => {
            1 => [ 24, 8, 17 ],   # Cage_number => [ pet_id, pet_id, pet_id ] 
            2 => [  ] ,
         },
      }
   };
   delete $self->{20090615};
   return bless $self;
}

sub available {
   my ($self, $res) = @_;
   return $self->reserve($res, "dry run");
}

sub reserve {
   my ($self, $res, $dry_run) = @_;

   # TODO: MAX_SMALL_CAGES, MAX_LARGE_CAGES caps
   # TODO: Intelligence about $res->payment?

   # TODO: Handle real dates, not these bogus integers.
   foreach my $date ($res->begin_date .. $res->end_date) {
      foreach my $pet (@{$res->pets}) {
         $DB::single = 1;
         my ($next_small_id) = reverse sort (keys %{$self->{$date}->{SMALL}});
         $next_small_id ||= 0;
         $next_small_id++;
         $self->{$date}->{SMALL}->{$next_small_id} = [ $pet ];
      }
   }
   return 1;
}

sub report {
   my ($self) = @_;
   my $rval;

   foreach my $date (sort keys %$self) {
      $rval .= "   $date\n";
      foreach my $cage_type (sort keys %{$self->{$date}}) {
         foreach my $cage_id (sort numerically keys %{$self->{$date}->{$cage_type}}) {
            $rval .= "      $cage_type#$cage_id: ";
            my @pets = @{$self->{$date}->{$cage_type}->{$cage_id}};
            foreach my $pet (@pets) {
               $rval .= sprintf("pet#%s (%s lb. %s) ", $pet->id, $pet->weight, $pet->type);
            };
            $rval .= "\n";
         }
      }
      $rval .= "\n";
   }
   return $rval;
}

sub numerically { $a <=> $b }
               
1;

