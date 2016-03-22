#!/usr/bin/perl -w
 
#  msockstat.perl
#  Author: Peez Gloriousintel
#  Last Edition: 07/09/2015
#  Contact: pj4dev.mit@gmail.com

print "Mac Sockstat by Peez Gloriousintel\n";
print "version 1.0 (https://github.com/Peez-Gloriousintel/Mac-Sockstat)\n";
$listening_port = `netstat -ant | grep LISTEN`;
@elements = split /\n/ , $listening_port;

%open_port = ();
foreach $socket (@elements) {
	@tmp = split /\s+/, $socket;
	$open_port{$socket} = [($tmp[0], $tmp[3])];
}

print "APP:PORT\tPID\tUSER\tVERSION\tPROTOCOL\tSOCKET\n";
foreach $socket (keys %open_port) {
	$open_port{$socket}[1] =~ /\.([0-9]+)$/;
	$port = $1;
	$output = `lsof -ni 4:$port | grep LISTEN`;
	chomp $output;
	$output =~ s/\s+/ /g;
	@outputs = split ' ', $output;
	print "$outputs[0]:$port\t$outputs[1]\t$outputs[2]\t$outputs[4]\t$outputs[7]\t\t$outputs[8] $outputs[9]\n" if ($output);
}
