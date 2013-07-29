<?php
error_reporting(0);

if(isset($_GET['mode']) and $_GET['mode'] == 'phpinfo') die(phpinfo());
if(isset($_GET['mode']) and $_GET['mode'] == 'getlogo')
{
    header('Content-type: image/png');  
    die(base64_decode('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'));
}

$config->langs['cn'] = '简体';
$config->langs['en'] = 'English';

$lang->cn->title = '欢迎使用息壤集成运行环境！';

$lang->cn->links['xirang']['link']       = '/xirang/';
$lang->cn->links['xirang']['text']       = '访问息壤';
$lang->cn->links['xirang']['target']     = '_self';

$lang->cn->links['official']['link']     = 'http://www.xirang.biz/';
$lang->cn->links['official']['text']     = '息壤官网';
$lang->cn->links['official']['target']   = '_blank';

$lang->cn->links['phpmyadmin']['link']   = '/phpmyadmin/';
$lang->cn->links['phpmyadmin']['text']   = '数据库管理';
$lang->cn->links['phpmyadmin']['target'] = '_blank';

$lang->cn->links['phpinfo']['link']      = '?mode=phpinfo';
$lang->cn->links['phpinfo']['text']      = 'PHP信息';
$lang->cn->links['phpinfo']['target']    = '_blank';

$lang->en->title = 'Welcome to use xirang!';

$lang->en->links['xirang']['link']       = '/xirang/';
$lang->en->links['xirang']['text']       = 'XiRang';
$lang->en->links['xirang']['target']     = '_self';

$lang->en->links['official']['link']     = 'http://www.xirang.biz/';
$lang->en->links['official']['text']     = 'Community';
$lang->en->links['official']['target']   = '_blank';

$lang->en->links['phpmyadmin']['link']   = '/phpmyadmin/';
$lang->en->links['phpmyadmin']['text']   = 'MySQL';
$lang->en->links['phpmyadmin']['target'] = '_blank';

$lang->en->links['phpinfo']['link']      = '?mode=phpinfo';
$lang->en->links['phpinfo']['text']      = 'PHP';
$lang->en->links['phpinfo']['target']    = '_blank';

$acceptLang = stripos($_SERVER['HTTP_ACCEPT_LANGUAGE'], 'zh-CN') !== false ? 'cn' : 'en';
$acceptLang = isset($_GET['lang']) ? $_GET['lang'] : $acceptLang;
$clientLang = $lang->$acceptLang;
?>
<html xmlns='http://www.w3.org/1999/xhtml'>
<head>
  <meta http-equiv='Content-Type' content='text/html; charset=utf-8' />
  <meta http-equiv="refresh" content="10; url=/xirang/" />
  <title><?php echo $clientLang->title;?></title>
  <style>
    html {background-color:#06294e;}
    body {font-family: Tahoma; font-size:14px}
    table{margin-top:200px; background:white; border:none}
    tr, th, td{border:none}
    a{text-decoration:none}

    #welcome{font-size:20px; border-bottom:1px solid #efefef; padding:10px}
    #logo{width:120px; border-right:1px solid #efefef}
    
    #links{padding-left:25px; font-size:14px}
    #links a{display:block; width:100px; height:25px; line-height:25px; float:left; margin-right:5px; border:1px solid gray; background:#efefef; text-align:center}
    #links #xirang{background:green; color:#efefef}
    
    #lang{background:#efefef; font-size:13px}
  </style>
</head>
<body>
  <table align='center' width='600'>
    <tr><th colspan='2' id='welcome'><?php echo $clientLang->title;?></th></tr>
    <tr>
      <td id='logo'><img src='?mode=getlogo' /></td>
      <td id='links'><?php foreach($clientLang->links as $linkID => $link) echo "<a id='$linkID' href='$link[link]' target='$link[target]'>$link[text]</a>";?></td>
    </tr>   
    <tr id='lang'>
      <td colspan='2' align='right'>
        <?php 
        foreach($config->langs as $langCode => $langName) echo "<a href='?lang=$langCode'>$langName</a> ";
        ?>
      </td>
    </tr>
  </table>
</body>
</html>
