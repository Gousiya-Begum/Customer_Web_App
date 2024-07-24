<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Sync Customer Data</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f4;
            margin: 0;
            padding: 0;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
        }
        .container {
            background-color: #fff;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            text-align: center;
            width: 100%;
            max-width: 500px;
        }
        h1 {
            margin-bottom: 20px;
            color: #333;
        }
        p {
            margin-bottom: 20px;
            color: #555;
        }
        button {
            padding: 10px 20px;
            font-size: 16px;
            color: #fff;
            background-color: #007bff;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            transition: background-color 0.3s ease;
        }
        button:hover {
            background-color: #0056b3;
        }
        .message {
            margin-top: 20px;
            font-size: 16px;
            color: #28a745;
        }
        .error-message {
            color: #dc3545;
        }
    </style>
    <script>
        function syncData() {
            const xhr = new XMLHttpRequest();
            const messageDiv = document.getElementById('message');
            xhr.open('GET', 'syncCustomerData', true);
            xhr.onload = function () {
                if (xhr.status === 200) {
                    messageDiv.textContent = 'Data synchronized successfully!';
                    messageDiv.className = 'message';
                } else {
                    messageDiv.textContent = 'Error syncing data: ' + xhr.statusText;
                    messageDiv.className = 'error-message';
                }
            };
            xhr.onerror = function () {
                messageDiv.textContent = 'Network error. Please try again later.';
                messageDiv.className = 'error-message';
            };
            xhr.send();
        }
    </script>
</head>
<body>
    <div class="container">
        <h1>Sync Customer Data</h1>
        <p>Click the button below to start synchronizing customer data from the remote API.</p>
        <button onclick="syncData()">Sync Now</button>
        <div id="message"></div>
    </div>
</body>
</html>
