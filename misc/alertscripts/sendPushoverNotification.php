#!/usr/bin/php
<?php
/**
 * Zabbix notification script, used to send zabbix notifications via pushover
 * to smartphones like an SMS.
 *
 * Usage: sendPushoverNotification <pushover-user-key> <subject> <message>
 
 * @author Marijn Koesen
 * @version 0.1
 */
 
define('PUSHOVER_APP_TOKEN', 'yourapptokenhere'); // Your 'Zabbix' app token from Pushover
 
if ($argc != 4)  {
    die("Usage: {$argv[0]} <pushover-user-key> <subject> <message>\n");
}
 
list($program, $to, $subject, $message) = $argv;
$lines = explode("\n", $message);

$ch = curl_init();
curl_setopt_array($ch, array(
    CURLOPT_URL => 'https://api.pushover.net/1/messages.json',
    CURLOPT_RETURNTRANSFER => true,
    CURLOPT_POSTFIELDS => array(
        'token' => PUSHOVER_APP_TOKEN, // the pushover app token
        'user' => $to, // the pushover user token
        'message' => $subject . "\n" . 
		     $lines[2] . "\n" .
		     $lines[3] . "\n" .
		     $lines[7] . "\n",
	'sound' => 'falling',
    )
));
 
$result = json_decode(curl_exec($ch), 1);
curl_close($ch);
 
if (!isset($result['status']) || $result['status'] != 1) {
    echo 'ERROR: could not send message, pushover said: "' . implode(', ', $result['errors']) . '"' . "\n";
}
?>
