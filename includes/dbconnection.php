<?php 
// InfinityFree production DB credentials.
define('DB_HOST','sql210.infinityfree.com');
define('DB_USER','if0_43300379');
// TODO: replace YOUR_VCPANEL_PASSWORD with your InfinityFree vPanel (hosting account) password.
define('DB_PASS','YOUR_VCPANEL_PASSWORD');
define('DB_NAME','if0_43300379_ems');
// Establish database connection.
try
{
$dbh = new PDO(
    "mysql:host=".DB_HOST.";dbname=".DB_NAME.";charset=utf8mb4",
    DB_USER,
    DB_PASS,
    array(PDO::ATTR_ERRMODE => PDO::ERRMODE_EXCEPTION)
);
}
catch (PDOException $e)
{
exit("Error: " . $e->getMessage());
}
?>