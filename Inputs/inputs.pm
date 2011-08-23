package Ocsinventory::Agent::Backend::OS::Generic::Inputs::inputs;

use strict;

sub check {
        return 1;
}

sub run {

     my $name="inputs";

      my $params = shift;
      my $common = $params->{common};

      my @cmd = ("cat /proc/bus/input/devices | grep N: | cut -d= -f2 > /tmp/InputDevices" );

      system(@cmd) == 0 or die "System @cmd fails: $?";

        open (RESULT_FILE, "/tmp/InputDevices") or die("Is there something wrong in findInputDevices.sh ???");

        while (<RESULT_FILE>) {
                chomp;

                $_ =~ s/"//g;

                $common->addInput({

                        'TYPE'          => "Input Device",
                        'MANUFACTURER'  => undef,
                        'CAPTION'       => undef,
                        'DESCRIPTION'   => $_,
                        'INTERFACE'     => undef,
                        'POINTTYPE'     => undef,

                });

        }

}

1;






