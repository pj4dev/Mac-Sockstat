#!/usr/bin/perl -w
 
#  @name: msockstat.perl
#  @author: pj4dev.mit@gmail.com
#  @updated_by: kim@kimhauser.ch
#  @last_edition: 11/15/2022

print "#========================================================\n";
print "| Mac Sockstat by pj4dev (update)\n";
print "| extended by jetedonner - 14.11.2022 (Added ESTABLISHED)\n";
print "| version 1.0.1c (https://github.com/pj4dev/Mac-Sockstat)\n";
print "#========================================================\n";

if ($ARGV[0] eq "-e") {  

    $listening_port = `netstat -ant | grep -E "LISTEN|ESTABLISHED"`;
    $establ = TRUE;
} else {
	$listening_port = `netstat -ant | grep LISTEN`;
	$establ = FALSE;
}

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

	if($establ) {
		$output = `lsof -ni 4:$port | grep -E "LISTEN|ESTABLISHED"`;
	} else {
		$output = `lsof -ni 4:$port | grep LISTEN`;
	}

	chomp $output;
	$output =~ s/\s+/ /g;
	@outputs = split ' ', $output;
	print "$outputs[0]:$port\t$outputs[1]\t$outputs[2]\t$outputs[4]\t$outputs[7]\t\t$outputs[8] $outputs[9]\n" if ($output);
}
