use strict; use warnings;
use Email::Stuffer qw(send);
use Email::Sender::Simple;
use Email::Sender::Transport::SMTP::TLS qw();
#################################
# EM - automated group-based send
#   password-protected-pdf attach
# DESC ##########################
# prior steps:
# 1) PDF.vba - vba to pdf (if necessary)
# 2) ATT.pl - password protect attachment
# SETUP #########################
print "batch: ";
my $batch = readline *STDIN; chomp $batch;
print "sender account: ";
my $sender = <>; chomp $sender;
print "$sender password: "; chomp $sender;
my $pass = <>; chomp $pass;
my %list; # key = email; value = attachment;
# LIST ##########################
open(my $lifh, '<', 'LIST.txt');
my @set = readline $lifh; chomp @set;
foreach my $line (@set) {
    my @i = split(" ", $line, 3);
    $list{$i[0]} = $i[1];
}
# SENDER #########################
my $trans = Email::Sender::Transport::SMTP::TLS->new(
    host => 'smtp.gmail.com',
    port => '587',
    username => $sender,
    password => $pass,
);
# LOOP ############################
foreach my $ee (keys %list) {
    my $att = "ATT\\$list{$ee}";
    print "sending $ee : $att\n";
    my $body = "$batch pay stub attached as a pdf\n";
    my $email = Email::Stuffer
        ->from ($sender)
        ->to ($ee)
        ->subject($batch)
        ->text_body($body)
        ->attach_file($att)
        ->transport($trans)
        ->send or print "error in trans $ee\n";
}
# NOTES ###########################
# GOOGLE
# If the sender is a google account change this setting
# https://www.google.com/settings/security/lesssecureapps
