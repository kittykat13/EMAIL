use strict; use warnings;
use CAM::PDF;
#################################
# ATT - group pdf pass-protection
# DESC ##########################
# take unprotected pdf attachements from
# PRE\PIN_filename;
# ex: PRE\4934_EEname.pdf;
# password protect with first 4 digits
# store as ATT\EEname.pdf;
# SETUP #########################
my $pre_location = 'PRE';
my $final_location = 'ATT';
opendir(my $pre, $pre_location);
my @list = readdir($pre); chomp @list;
shift @list; shift @list;
print "@list\n";
foreach my $i (@list) {
  my @tmp = split('_', $i, 2);
  my $pin = $tmp[0]; my $attach = $tmp[1];
  my $x = "$pre_location\\$i";
  print "$x\n";
# ENCRYPT WITH PIN ##########
  my $pdf = CAM::PDF->new($x) or die "fail\n";
  $pdf->setPrefs($pin,$pin);
# SAVE FINAL ATTACHMENT #####
  my $doc = "$final_location\\$attach";
  $pdf->output($doc);
}
