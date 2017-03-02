use strict; use warnings;
use CAM::PDF;
###########################
# ATT - pdf pass protection
my $pre_location = 'PRE';
my $final_location = 'ATT';
# PRE/PIN_filename;
# ex: PRE/4934_MNat.pdf;
my @list = readdir($pre_location); chomp @list;
foreach $i (@list) {
  my @tmp = split('_', $i, 2);
  my $attach = $tmp[0]; my $pin = $tmp[1];
# ENCRYPT WITH PIN #######
  my $i = CAM::PDF->new();
# SAVE FINAL LOC #########
}
