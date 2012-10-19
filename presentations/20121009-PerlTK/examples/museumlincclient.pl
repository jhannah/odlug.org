#!/usr/bin/perl

use Tk;
use Tk::HyperText;
use Tk::LabEntry;
use Tk::DialogBox;
use MLDP;
use YAML qw/LoadFile DumpFile/;

$Mw = MainWindow->new(-title=> "MuseumLinc Client");
$Mw->optionAdd("*tearOff", 'false');
$menuitems = [
    [Cascade=> "~File", -menuitems=>
     [
      [Button=> "~Connect", -command=> \&connect],
      [Button=> "~Disconnect", -command=> \&disconnect]
     ]
    ],
    [Cascade=> "~Edit", -menuitems=>
     [
      [Cascade=> "~Items", -menuitems=>
       [
	[Button=> "~Add", -command=> \&additem],
	[Button=> "~Manage", -command=> \&manageitems],
	[Button=> "~Remove", -command=> \&remitem]
       ]
      ],
      [Cascade=> "M~ultiMedia", -menuitems=>
       [
	[Button=> "~Add", -command=> \&addmm],
	[Button=> "~Manage", -command=> \&managemm],
	[Button=> "~Remove", -command=> \&remmm]
       ]
      ],
      [Cascade=> "~Addressess", -menuitems=>
       [
	[Button=> "~Add", -command=> \&addaddr],
	[Button=> "~Manage", -command=> \&manageaddr],
	[Button=> "~Remove", -command=> \&remaddr]
       ]
      ],
      "Seperator",
      [Button=> "~Run Plugins", -command=> \&runplugins],
      [Button=> "Manage ~Plugins", -command=> \&mplugions],
      "Seperator",
      [Button=> "~Server Settings", -command=> \&server]
     ]
    ],
    [Cascade=> "~Management", -menuitems=>
     [
      [Button=> "Museum ~Information", -command=> \&museuminfo],
      [Button=> "Mail ~Blast", -command=> \&mailBlast]
     ]
    ],
    [Cascade=> "~Help", -menuitems=>
     [
      [Button=> "~Help", -command=> \&help],
      [Button=> "System ~Docs", -command=> \&docs],
      [Button=> "~About", -command=> \&about]
     ]
    ]
    ];
$mbar = $Mw->Menu(-menuitems=> $menuitems);
$Mw->configure(-menu=> $mbar);



MainLoop();

sub docs{
    $tlw = $Mw->Toplevel(-title=> "Help");
    $topics = $tlw->Scrolled('Listbox', -scrollbars=> 'ose')->pack(-side=> 'left', -anchor=> 'nw', -expand=> 1, -fill=> 'y');
    $harea = $tlw->Scrolled("HyperText", -scrollbars=> 'ose', -wrap=> 'word')->pack(-side=> 'left', -anchor=> 'nw', -expand=> 1, -fill=> 'both');
    $topics->insert('end', []);
    $topics->bind('<Button-1>', [sub { $harea->loadString($docs{$topics->get($topics->curselection())}); }]);
}

sub help{
    $tlw = $Mw->Toplevel(-title=> "Help");
    $topics = $tlw->Scrolled('Listbox', -scrollbars=> 'ose')->pack(-side=> 'left', -anchor=> 'nw', -expand=> 1, -fill=> 'y');
    $harea = $tlw->Scrolled("HyperText", -scrollbars=> 'ose', -wrap=> 'word')->pack(-side=> 'left', -anchor=> 'nw', -expand=> 1, -fill=> 'both');
    $topics->insert('end', []);
    $topics->bind('<Button-1>', [sub { $harea->loadString($help{$topics->get($topics->curselection())}); }]);
}

sub about{
    $tlw = $Mw->Toplevel(-title=> "About MuseumLinc");
    $tlw->Label(-text=> "MuseumLinc $version, Copyright 2012,\nI'm Running Out of Ideas, LLC.\n Licensed under the IROI Public Source License.")->pack();
    $tlw->Button(-text=> "Ok", -command=> sub { $tlw->withdraw(); })->pack();
}
