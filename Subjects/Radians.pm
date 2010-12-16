#! /usr/bin/perl

use strict;
use 5.010;

package Radians;
        use Math::Trig;
        sub new() {
                my $proto = shift;
                my $class = ref($proto) || $proto;
                my $subject = shift;
                my $self = {};
                bless ($self, $class);
                return $self;

                $self->{questiontype} = rand(!00);
        }

        sub question() {
                my $self = shift;
                given($self->{questiontype}){
                        when ($_ < 25){
                                # Find area of sector
                                $self->{r} = int(rand(100));
                                $self->{theta} = int(rand( 2 * pi ));
                                return "A circle has radius $self->{r}. Find the area of a sector with an angle of $self->{theta} radians";
                        }
                        when (($_ >= 25) && ($_ < 50)){
                                # Find length of arc
                                $self->{r} = int(rand(2 * pi));
                                $self->{theta} = int(rand(2 * pi));
                                return "A circle has radius $self->{r}, find the length of the arc"
                        }
                        when (($_ >= 50) && ($_ < 75)){
                                # degs rads:
                                $self->{theta} = int(rand((2 * pi)));
                                return "express $self->{theta}rad in degrees";
                        }
                        default{
                                # rads degs
                                $self->{theta} = int(rand(360));
                        }

                }
        }

        sub answer() {
                my $self = shift;
                my $guess = shift;
                $guess = sprintf("%.2f", $guess);
                my $answer;
                given($self->{questiontype}){
                        when ($_ < 25){
                                $answer = ($self->{r} * $self->{r} * $self->{theta})/2;
                                $answer = sprintf("%.2f", $answer);
                        }
                        when (($_ >= 25) && ($_< 50)){
                                $answer = $self->{r} * $self->{theta};
                                $answer = sprintf("%.2f", $answer);
                        }
                        when (($_ >= 50) && ($_ < 75)){
                                $answer = ($self->{theta} / 360) * ( 2 * pi );
                                $answer = sprintf("%.2f", $answer);
                        }
                        default{
                                $answer = ($self->{theta} / (2 * pi )) * 360;
                                $answer = sprintf("%.2f", $answer);
                        }
                }
                if ($guess != $answer){
                        return $answer;
                }else{
                        return;
                }
        }



1;
