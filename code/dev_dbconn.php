<?php
$db_host = 'web_db';
$db_name = 'dev';
$db_user = 'devuser';
$db_password = 'devuserpass';
$db_driver = 'mysql';
$db_charset = "utf8";
$db_port = 3306;
$pdo_dsn = "{$db_driver}:host={$db_host};port={$db_port};dbname={$db_name};charset={$db_charset}";
$pdo_opt = [PDO::ATTR_DEFAULT_FETCH_MODE => PDO::FETCH_BOTH];

$res_html = "";

$db_conn = @new pdo($pdo_dsn, $db_user, $db_password, $pdo_opt) or die("failed to create PDO DB link source");

$stmt = $db_conn->prepare("DESCRIBE devtable");
$stmt->execute();
$fields = $stmt->fetchAll(PDO::FETCH_COLUMN);

$res_html .= "<tr>";
foreach($fields as $field) {
    $res_html .= "<th>" . $field . "</th>";
}
$res_html .= "</tr>";

$sql = "SELECT * FROM devtable LIMIT 10";
$stmt = $db_conn->prepare($sql);
$stmt->execute();

while ( $row = $stmt->fetch(PDO::FETCH_ASSOC)) {

    $res_html .= "<tr>";
    foreach($row as $val) {
        $res_html .= "<td>" . $val . "</td>";
    }
    $res_html .= "</tr>";
}

$res_html = "<table>" . $res_html . "</table>";

echo $res_html;