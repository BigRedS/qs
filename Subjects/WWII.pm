#! /usr/bin/perl

use strict;
package WWII;
        sub new{
                my $proto = shift;
                my $class = ref($proto) || $proto;
                my $subject = shift;
                my $self  = {}; 
                bless ($self, $class);
                return $self;
        }   
     
        sub question() {
                return "When did WWII begin?";
        }   
     
        sub answer() {
                my $self = shift;
                my $guess = shift;
                if ($guess =~ /1939/){
                        return;
                }else{
                        return "1939";
                }   
        }   
1;
