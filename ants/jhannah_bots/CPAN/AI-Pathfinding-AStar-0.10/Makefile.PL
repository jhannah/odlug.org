use ExtUtils::MakeMaker;
# See lib/ExtUtils/MakeMaker.pm for details of how to influence
# the contents of the Makefile that is written.
WriteMakefile(
    'NAME'		=> 'AI::Pathfinding::AStar',
    'VERSION_FROM'	=> 'lib/AI/Pathfinding/AStar.pm', # finds $VERSION
    'PREREQ_PM'		=> {
				Heap::Binomial => 0, 
				Heap::Elem => 0, 
				Test::More => 0.11,
			   },
    ($] >= 5.005 ?
		(ABSTRACT_FROM	=> 'lib/AI/Pathfinding/AStar.pm',
		AUTHOR		=> 'Aaron Dalton <aaron@daltons.ca>') : ()),
);
