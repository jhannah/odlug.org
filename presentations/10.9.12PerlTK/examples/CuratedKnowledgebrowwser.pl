#!/usr/bin/perl

use Tk;
use Tk::Tree;
use Tk::HyperText;
use Text::Markdown 'markdown' ;
use YAML qw/LoadFile DumpFile/;

$Mw = MainWindow->new(-title=> "Curated Knowledge Browser");


$Mw->optionAdd("*tearOff", "false");
$menuitems = [
	      [Cascade => "~File", -menuitems=>
	       [
		[Button => "~Load", -command=> \&load],
		[Button => "~Save", -command=> \&save],
		"Seperator",
		[Button => "E~xit", -command=> \&closeup]
	       ]
	      ],
	      [Cascade=> "~Help", -menuitems=> 
	       [
		[Button=> "~About", -command=> \&about],
		[Button=> "~Help", -command=> \&help]
	       ]
	      ]
	     ];
$menubar = $Mw->Menu(-menuitems => $menuitems);
$Mw->configure(-menu=> $menubar);

$browsetree = $Mw->Scrolled('Tree', -scrollbars=> 'osw', -browsecmd=> \&browse)->pack(-expand=> 1, -fill=> 'both');
$browsetree->configure(-separator=> '/');


MainLoop();

sub load{
  our $file = $Mw->getOpenFile(-title=> "Open Curated Knowledge DB", -filetypes=> [['CKF DB', '.ckf'], ['All Files', '*']], -defaultextension=> '.ckf');
  $data = LoadFile($file);
  parse();
}

sub parse{
  $browsetree->delete('all');
  foreach $node (@{$data->{nodes}}){
    $name = (split('/', $node))[-1];
    $name = $node if ($name eq '');
    $browsetree->add($node);
    $browsetree->itemCreate(
			    $node, 0,
			    -text     => $name,
			    -itemtype => 'text');
  }
  $browsetree->autosetmode();
}

sub save{
  if(defined($file)){
    DumpFile($file, $data);
  }else{
    $file = $Mw->getSaveFile(-title=> "Save Curated Knowledge DB", -filetypes=> [['CKF DB', '.ckf'], ['All Files', '*']], -defaultextension=> '.ckf');
    DumpFile($file, $data);
  }
}

sub about{
  $tlw = $Mw->Toplevel(-title=> "About");
  $tlw->Label(-text=> "Curated Knowledge Browser\nCopyright IROI 2012.\nLicensed under the IROI PSL")->pack();
  $tlw->Button(-text=> "Ok", -command=> sub { $tlw->withdraw(); })->pack();
}

sub help{
  clear();

}

sub clear{
  $browsetree->delete('all');
  $data = {};
  $file = undef;
}

sub browse{
  $address = shift;
  $tlw = $Mw->Toplevel(-title=> "$address");
  $area = $tlw->Scrolled("HyperText", -scrollbars=> 'osw')->pack(-fill=>"both", -expand=>1);
  $area->loadString(markdown($data->{dat}->{$address}));
}
