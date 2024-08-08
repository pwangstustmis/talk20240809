<?php
// 資料庫連接參數
$servername = "localhost";
$username = "root"; // 默認用戶名
$password = ""; // 默認密碼
$dbname = "student_db";

// 建立連接
$conn = new mysqli($servername, $username, $password, $dbname);

// 檢查連接
if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
}

// 獲取表單數據
$name = $_POST['name'];
$age = $_POST['age'];
$email = $_POST['email'];

// 準備 SQL 語句
$sql = "INSERT INTO students (name, age, email) VALUES ('$name', $age, '$email')";

// 執行 SQL 語句
if ($conn->query($sql) === TRUE) {
    echo "新記錄插入成功";
} else {
    echo "錯誤: " . $sql . "<br>" . $conn->error;
}

// 關閉連接
$conn->close();
?>
