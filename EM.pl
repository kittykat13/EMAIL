use strict; use warnings;
use Email::Sender::Simple qw(sendmail);
use Email::Sender::Transport::SMTP::TLS qw();
use Email::Simple;
use Try::Tiny;
#################################
# EM - automated group-based send
#   password-protected-pdf attach
# DESC ##########################
# prior steps: 
# 1) PDF.vba - vba to pdf (if necessary)
# 2) ATT.pl - password protect attachment
# SETUP #########################
print "batch: ";
my $batch = <>; chomp $batch;
print "sender account: ";
my $sender = <>; chomp $sender;
print "$sender password: "; chomp $sender;
my $pass = <>; chomp $pass;
# LIST ##########################
print "Readn LIST\n"; 
my %list; 
# key = email_address; 
# value = attachment;
open(my $lifh, '<', 'LIST');
my @set = readline $lifh; chomp @pre;
foreach $line (@set) {
    my @i = split(" ", $line, 3);
    $list{$i[0]} = $i[1];
}
# SKIP rm key without file in ATT folder
#    next unless exists $att;
# SENDER #########################
my $trans = Email::Sender::Transport::SMTP::TLS->new(
    host => 'smtp.gmail.com',
    port => '587',
    username => $sender,
    password => $pass,
);
# LOOP ############################
foreach $ee (keys %list) {
    my $att = $list{$ee};

    my $email = Email::Simple->create(
        header => [
            To => $ee,
            From => $sender,
            Subject => "Paystub $batch",
            # ATTACH 
        ],
        body => "$batch pay stub attached as a pdf\n",
    );
    try {
        sendmail($email, { transport => $trans });
    } catch {
        die "Error sending email: $_";
    };
}
# NOTES ###########################
# GOOGLE
# If the sender is a google account change this setting
# https://www.google.com/settings/security/lesssecureapps
