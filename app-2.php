<!DOCTYPE html>
<html>
<head>
    <title>學生資料表單</title>
</head>
<body>
    <h1>新增學生資料</h1>
    <form action="process.php" method="post">
        <label for="name">姓名:</label>
        <input type="text" id="name" name="name" required><br><br>

        <label for="age">年齡:</label>
        <input type="number" id="age" name="age" required><br><br>

        <label for="email">電子郵件:</label>
        <input type="email" id="email" name="email" required><br><br>

        <input type="submit" value="提交">
    </form>
</body>
</html>
