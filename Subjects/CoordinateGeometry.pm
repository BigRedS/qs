#! /usr/bin/perl

use strict;
use 5.010;

package CoordinateGeometry;
#use base qw(Questions);
#use Questions::Utils;
        sub new{
                my $proto = shift;
                my $class = ref($proto) || $proto;
                my $self  = {};
                my $range = 100;
                $self->{x1} = int(rand($range));
                $self->{y1} = int(rand($range));
                $self->{x2} = int(rand($range));
                $self->{y2} = int(rand($range));
                $self->{questionType} = int(int(rand($range)));


                bless ($self, $class);
                return $self;
        }

        sub question(){
                my $self = shift;
                if($self->{questionType} > 50){
                        return "Find the midpoint of ($self->{x1},$self->{y1}) and ($self->{x2}, $self->{y2})";
                }else{
                        return "Find the distance between ($self->{x1},$self->{y1}) and ($self->{x2}, $self->{y2})";
                }
        }

        sub answer(){
                my $self = shift;
                my $guess = shift;
                if($self->{questiontype} > 50){
                        my $answer_x = int (($self->{x1}+$self->{x2})/2);
                        my $answer_y = int (($self->{y1}+$self->{y2})/2);
                        if ($guess =~ /$answer_x,$answer_y/){
                                return "Correct! $guess = $answer_x,$answer_y\n";
                        }else{
                                return "Wrong! $guess != $answer_x,$answer_y\n";
                        }
                }else{
                        my $x_len = $self->{x2} - $self->{x1};
                        my $y_len = $self->{y2} - $self->{y1};
                        my $answer = int ( sqrt( ($y_len**2) + ($x_len**2)));
                        if ($guess != $answer){
                                return "$answer";
                        }else{
                                return ;
                        }
                }
        }


1;
