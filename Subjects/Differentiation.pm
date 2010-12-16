#! /usr/bin/perl

use strict;
use 5.010;

package Differentiation; 

        sub new{ 
                my $proto = shift; 
                my $self = {}; 
                my $class = ref($proto) || $proto;
                # Coefficients:
                my $range=10;
                $self->{a}=int(rand($range));
                $self->{b}=int(rand($range));
                $self->{c}=int(rand($range));
        
                # Indicies:
                $range=4;
                $self->{p}=int(rand($range));
                $self->{q}=int(rand($range));
                $self->{r}=int(rand($range));

                # X:
                $range=5;
                $self->{x}=int(rand($range));
                bless($self, $class);
                return $self;
        }
        sub question(){
                my $self = shift;
                my $equation = $self->{a} . "X^" . $self->{p} . " + " . $self->{b} . "X^" . $self->{s};
                return "Solve dy/dx for ".$equation." where X = $self->{x}";
#               return "Solve dy/dx for ".$a."X^".$p." + ".$b."X^".$q." + ".$c."X^".$r."where 
        }
        sub answer(){
                my $self = shift;
                my $guess = shift;
                $guess = sprintf("%.2f", $guess);

                my $a = $self->{a};
                my $b = $self->{b};
                my $c = $self->{c};
                my $p = $self->{p};
                my $q = $self->{q};
                my $r = $self->{r};
                my $x = $self->{x};


                my $answer = ($p*$a * ($x ** ($p-1)));
                $answer = $answer + ($q*$b * ($x ** ($q-1)));
                $answer = $answer + ( $r*$c * ($x ** ($r-1)));
                $answer = sprintf("%.2f", $answer);
                
                if($guess != $answer){
                        return $answer;
                }else{
                        return;
                }
 	}       
	
1;
