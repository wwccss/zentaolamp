#!/usr/bin/env php
<?php
/**
 * This is is used to create start and start88 control files.  
 */
/* Judge argv count and get product var. */
if(count($argv) != 2) die('./createControl.php product=zentao|xirang|common');
$product = $argv[1];

/* Create start control file. */
$apacheFromPort = 88;
$apacheToPort   = 80;
$mysqlFromPort  = 3308;
$mysqlToPort    = 3306;

file_put_contents('./start', createStart(file_get_contents('../start.tpl'), $product));

/* Create start88 control file. */
$apacheFromPort = 80;
$apacheToPort   = 88;
$mysqlFromPort  = 3306;
$mysqlToPort    = 3308;

file_put_contents('./start88', createStart(file_get_contents('../start.tpl'), $product));

/**
 * Create start.
 * 
 * @param  string    $startTPL 
 * @param  string    $product 
 * @access public
 * @return void
 */
function createStart($startTPL, $product)
{
    global $apacheFromPort, $apacheToPort, $mysqlFromPort, $mysqlToPort;

    $startTPL = str_replace('{apacheFromPort}', $apacheFromPort, $startTPL);
    $startTPL = str_replace('{apacheToPort}',   $apacheToPort,   $startTPL);
    $startTPL = str_replace('{mysqlFromPort}',  $mysqlFromPort,  $startTPL);
    $startTPL = str_replace('{mysqlToPort}',    $mysqlToPort,    $startTPL);

    if($product == 'zentao' or $product == 'xirang')
    {
        $startTPL = str_replace('{product}', $product, $startTPL);
        return $startTPL;
    }

    $startTPL = explode("\n", $startTPL);
    foreach($startTPL as $key => $line)
    {
        if(strpos($line, '{product}') !== false) unset($startTPL[$key]);
    }

    return join("\n", $startTPL);
}
