#! /usr/bin/perl

# requires: dbi (libdbi-perl)

# This is free software. It is licensed under the FreeBSD 	#
# license which you can find here:				#
#    http://www.freebsd.org/copyright/freebsd-license.html	#


# Configuration is read from /home/.maths/config. This requires some
# paramaters be set, but doesn't actually test for any of them. They 
# are, in no particular order, as follows:
#  cheatmode		if set to 'yes', wil display the answer when
#			asking the question
#  test_only		if set to 'yes', will only ask one really basic
#			question, the answer to which is 42
#  verbosity		if set to 'info', prints odd bits of information
#			to STDERR during operation. When set to debug it 
#			prints more
# MySQL db info:
#  db_host db_port db_name db_user db_pass

# The subjects on which to ask qustions are defined in @questions. 
# This is an array of subroutine names, which are picked and 
# executed at random.

#use strict; 	# I know, I know. But &{$subName}() doesn't work
		# in strict, and I just need to make it work. I 
		# promise I'll modify it to work in strict. 

use 5.010;
use Math::Trig;
use DBI;
use DBD::mysql;
use Subjects::CoordinateGeometry;
use Subjects::Differentiation;
use Subjects::Radians;
use Subjects::SequencesAndSeries;
use Subjects::WWII;
my $home = $ENV{HOME};

$SIG{INT} = \&exit;

my $configFile = "$home/.maths/conf";
my ($cheatmode, $dbHost, $dbName, $dbUser, $dbPass, $verbosity,$useDb, $subjectsDir);

open ($c, "<", $configFile) or die ("ERROR: Couldn't open configfile $configFile\n");
while(<$c>){
	unless($_ =~ /^#/){
		chomp;
		my ($key,$value)=(split(/=/, $_))[0,1];
		if ($key =~ /cheat/){
			if ($value =~ /^yes$/i){
				$cheatmde = 1;
			}else{
				$cheatmode = 0;
			}
		}elsif($key=~/db_host/i){
			$dbHost = $value;
		}elsif($key=~/db_port/i){
			$dbPort = $value;
		}elsif($key=~/db_name/i){
			$dbName = $value;
		}elsif($key=~/db_user/i){
			$dbUser = $value;
		}elsif($key=~/db_pass/i){
			$dbPass = $value;
		}elsif($key=~/db_host/i){
			$dbHost=$value;
		}elsif($key=~/mathsdir/i){
			$mathsdir = $value;
		}elsif($key=~/default_number_of_questions/i){
			$numQs = $value;
		}elsif($key=~/verbosity/i){
			if($value =~/info/i){$verbosity=1;}
			if($value =~/debug/i){$verbosity=2;}
		}elsif($key=~/subjects_dir/){
			$subjectsDir = $value;
		}elsif($key=~/write_to_db/){
			if($value=~/no/){$useDb = 0;}else{$useDb = 1;}
		}else{
			print STDERR "WARN: Unexpected option: $key\n";
		}
	}
}
close ($c);

if($verbosity > 1){print STDERR "DEBUG: mathsdir=$mathsdir numQs=$numQs testOnly=$testOnly verbosity=$verbosity cheatmode=$cheatmode\n";}
if($verbosity > 0){print STDERR "INFO:  dbName=$dbName dbHost=$dbHost dbUser=$dbUser dbPass=$dbPass\n";}

if($useDb != 0){&connectToDb($dbHost, $dbName, $dbPort, $dbUser, $dbPass, $verbosity);}

my $startTime = time();
if($verbosity > 1){print STDERR "DEBUG: startTime: $startTime\n";}

&usage if ($ARGV[0] =~ /\D/);
my $num = $ARGV[0];
if (!($num > 0)){ $num = $numQs; }

# Bunch of welcoming text
&welcome;

my @subjects = &getSubjects("$subjectsDir");
my $numSubjects = @subjects;

## Right then, let's ask some questions:
&quiz ($num); 


sub quiz() {
	my $numQs = shift;
	my $session = time();
	my @qs;
	for ($i=1; $i<($numQs+1); $i++){
		my $questionTime = time();
		my $a = int(rand($numSubjects));
       		my $q = $subjects[$a]->new();

		say $i."\t".$q->question;
        	my $a = <STDIN>;
        	chomp $a;
		my $r = $q->answer($a);
		my $correct;
        	if (!$r){
			say "\tCorrect!";
			$correct = 1;
		}else{
			say "Nope. Should have been $r\n\n";
			$correct = 0;
		}
		$n++;
		if($useDb != 0){
			my $query = "insert into granular (session, startTime, questionTime, answerTime, subject, correct, cheatmode, test)";
			$query.="values ('$session', FROM_UNIXTIME($session), FROM_UNIXTIME($questionTime), '$answerTime', '$subject', '$correct', '$cheatmode', '$test')";
			$query_handle = $con->prepare($query);
			$query_handle->execute();
		}
	}
}

sub usage() {

	say $0;
	say "USAGE";
	say "\t$0 [number of questions] [subject]";
	say "";
	say "If no number is supplied, I'll go on forever, and there's\nno way of telling me to quit in a way that records your progress\n";
	print "Available subjects:\n";
	foreach (@questions){
		print "\t$_\n";
	}
	exit 1;

}


sub exit {
	print "exiting...\n";
	exit 0;

}

sub welcome{
#	say "Welcome to Avi's Magical Q+A thingy. You will be answering questions on:\n";
#	foreach(@questions){
#		print "\t";
#		my $subject = $_;
#		$subject =~ s/_/ /g;
#		say $subject;
#	}
#	say "\nRemember, all answers are rounded DOWN. That is, truncated to the decimal";
#	say "point. 24.7 = 24.";
}

sub getSubjects(){
	my $subjectsDir = shift;
	my @subjects;
	opendir ($dh, $subjectsDir) or die ("ERROR  : cannot open subjectsDir $subjectsDir");
	while(my $fn = readdir($dh)){
		if ($fn =~ /pm$/){
			$subject = (split(/\./, $fn))[0];
			push (@subjects, $subject);
		}
	}
	return @subjects
}

sub connectToDb (){
	my ($dbHost, $dbName, $dbPort, $dbUser, $dbPass, $verbosity) = @_;
	if($verbosity > 1){print STDERR "INFO:  Connecting to db ($dbHost)...";}
	my $dsn = "dbi:mysql:$dbName:$dbHost:$dbPort";
	my $con = DBI->connect($dsn, $dbUser, $dbPass) or die "Error connecting to db";
	if($verbosity > 1){print STDERR "done.\n";}
}
