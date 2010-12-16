#! /usr/bin/perl

use strict;
use 5.010;

package SequencesAndSeries;
        sub new() {
                my $proto = shift;
                my $class = ref($proto) || $proto;
                my $subject = shift;
                my $self = {};
                $self->{a} = int(rand(100));
                $self->{r} = 2 + int(rand(8));
                $self->{n} = 4 + int(rand(8));
                $self->{terms} = [];
                $self->{terms}[0] = $self->{a};
                my $i;
                for($i = 1; $i<5; $i++){
                        $self->{terms}[$i] = $self->{terms}[$i-1] * $self->{r};
                }
                bless ($self, $class);
                return $self;
        }

        sub question(){
                my $self = shift;
                my $question = "Find the $self->{n} th term of the series\n\t";
                foreach (@{$self->{terms}}){
                        $question.=" $_ ";
                }
                return $question;
        }

        sub answer(){
                my $self = shift;
                my $guess = shift;
                $guess = sprintf("%.2f", $guess);
                my $answer = $self->{a} * ($self->{r}**($self->{n}-1));
                $answer = sprintf("%.2f", $guess);

                if ($answer != $guess){
                        return $answer;
                }else{
                        return;
                }
        }
1;
