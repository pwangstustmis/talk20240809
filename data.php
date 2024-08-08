<?php
header('Content-Type: application/json');

// 資料庫連接參數
$servername = "localhost";
$username = "root";
$password = "";
$dbname = "location_db";

// 建立連接
$conn = new mysqli($servername, $username, $password, $dbname);

// 檢查連接
if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
}

// 查詢位置數據
$sql = "SELECT latitude, longitude, description FROM locations";
$result = $conn->query($sql);

$locations = array();

if ($result->num_rows > 0) {
    // 讀取數據
    while ($row = $result->fetch_assoc()) {
        $locations[] = $row;
    }
}

// 輸出 JSON 格式數據
echo json_encode($locations);

$conn->close();
?>