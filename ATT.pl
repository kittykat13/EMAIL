use strict; use warnings;
use CAM::PDF;
###########################
# ATT - pdf pass protection
my $pre_location = 'PRE';
my $final_location = 'ATT';
# PRE/PIN_filename;
# ex: PRE/4934_EEname.pdf;
opendir(my $pre, $pre_location);
#opendir(my $fin, $final_location);
my @list = readdir($pre); chomp @list;
shift @list; shift @list;
print "@list\n";
foreach my $i (@list) {
  my @tmp = split('_', $i, 2);
  my $pin = $tmp[0]; my $attach = $tmp[1];
  my $x = "$pre_location\\$i";
  print "$x\n";
# ENCRYPT WITH PIN #######
  my $pdf = CAM::PDF->new($x) or die "fail\n";
  $pdf->setPrefs($pin,$pin);
# SAVE FINAL LOC #########
  my $doc = "$final_location\\$attach";
  $pdf->output($doc);
}
