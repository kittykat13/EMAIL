use strict; use warnings;
use Email::Sender::Simple qw(sendmail);
use Email::Sender::Transport::SMTP::TLS qw();
use Email::Simple;
use Try::Tiny;
#########################################
# EM - automated send to group-recipients
#                  see NOTE section below
# SETUP #################################
print "batch: ";
my $batch = <>; chomp $batch;
print "sender account: ";
my $sender = <>; chomp $sender;
print "$sender password: "; chomp $sender;
my $pass = <>; chomp $pass;
print "Readn LIST\n"; 
open(my $lifh, '<', 'LIST');
my @list = readline $lifh; chomp @list;
print "@list\n";

# SENDER ###############################
my $trans = Email::Sender::Transport::SMTP::TLS->new(
    host => 'smtp.gmail.com',
    port => '587',
    username => $sender,
    password => $pass,
);
# LOOP #################################
my $email = Email::Simple->create(
    header => [
        To => $i,
        From => $sender,
        Subject => "Paystub $batch",
    ],
    body => "Pay Stub attached as a pdf\n",
);
try {
    sendmail($email, { transport => $trans });
} catch {
    die "Error sending email: $_";
};

# NOTES #################
# GOOGLE
# If the sender is a google account change this setting
# https://www.google.com/settings/security/lesssecureapps

