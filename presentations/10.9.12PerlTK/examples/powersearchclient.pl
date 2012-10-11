#!/usr/bin/perl

use Tk;
use IO::Socket;
use YAML qw/LoadFile DumpFile/;
use v5.14;
no strict;

$conf = LoadFile("srclient.yaml");

$Mw = MainWindow->new(-title=> "PowerSearch Client");
$Mw->optionAdd("*tearOff", "false");
$menuitems = [
    [Cascade => "~File", -menuitems=>
     [
      [Cascade => "~Save Results", -menuitems=>
       [
	[Button => "~Y-Bib", -command=> \&saveybib],
	[Button => "~CSV-Bib", -command=> \&savecsvbib],
	[Button => "~Html", -command=> \&savehtml],
	[Button => "~Text", -command=> \&savetext]
       ]
      ],
      [Button => "~Open", -command=> \&openfile],
      "Seperator",
      [Button => "E~xit", -command=> \&closeup]
     ]
    ],
    [Cascade => "Se~rver", -menuitems=>
     [
      [Button => "Se~ttings", -command=> \&settings],
      [Button => "~Connect", -command=> \&connect],
      [Button => "~Disconnect", -command=> \&dconnect],
      "Seperator",
      [Button => "Server ~Information", -command=> \&info],
      [Button => "Special Co~mmand", -command=> \&special]
     ]
    ],
    [Button => "~Help", -command=> \&help]
    ];
$menubar = $Mw->Menu(-menuitems => $menuitems);
$Mw->configure(-menu=> $menubar);

$sframe = $Mw->Frame(-relief=> 'ridge')->pack(-fill=> 'x', -expand=> 1, -anchor=> 'nw');
$sframe->Button(-text=> "Sources", -command=> \&setsources)->pack(-side=> 'left');
$sframe->Entry(-textvariable=> \$searchterms)->pack(-side=> 'left', -expand=> 1, -fill=> 'x');
$sframe->Button(-text=> "Search", -command=> \&search)->pack(-side=> 'left');

$Mw->Label(-text=> "MORE STUFF GOES HERE!")->pack();


MainLoop();

sub saveybib{
    
}

sub savecsvbib{
    
}

sub savehtml{
    
}

sub savetext{
    
}

sub openfile{
    
}

sub closeup{
    
}

sub settings{
    
}

sub connect{
    
}

sub dconnect{
    
}

sub info{
    
}

sub special{
    
}

sub help{
    $tlw = $Mw->Toplevel(-title=> "Help System");
    $hmen = $tlw->Listbox(-width=> 30)->pack(-side=> 'left', -fill=> 'y', -expand=> 1, -anchor=> 'w');
    $hmen->insert('end', keys(%help));
    $hmen->bind('<Button-1>', [sub{$topic = $hmen->get($hmen->curselection()); $htmler->loadstring($help{$topic});}]);
    $htmler = $tlw->Scrolled('HyperText', -scrollbars=> 'osoe', -wrap=> 'word')->pack(-side=> 'left', -fill=> 'both', -expand=> 1, -anchor=> 'w');
}

sub setsources{
    
}

sub search{
    
}

__END__

