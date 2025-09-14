<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login - Elite Store</title>
    <link href="https://fonts.googleapis.com/css2?family=Roboto:wght@400;500;700&display=swap" rel="stylesheet">
    <style>
        :root {
            --background: hsl(210, 36%, 96%);
            --foreground: hsl(222, 47%, 11%);
            --card: hsl(0, 0%, 100%);
            --card-foreground: hsl(222, 47%, 11%);
            --primary: hsl(205, 78%, 60%);
            --primary-foreground: hsl(0, 0%, 98%);
            --primary-glow: hsl(205, 78%, 70%);
            --secondary: hsl(210, 31%, 91%);
            --secondary-foreground: hsl(222, 47%, 11%);
            --muted: hsl(210, 31%, 91%);
            --muted-foreground: hsl(215, 16%, 47%);
            --accent: hsl(205, 78%, 60%);
            --accent-foreground: hsl(0, 0%, 98%);
            --border: hsl(210, 31%, 91%);
            --input: hsl(210, 31%, 91%);
            --ring: hsl(205, 78%, 60%);
            --radius: 1rem;
            --gradient-primary: linear-gradient(135deg, hsl(205, 78%, 60%), hsl(205, 78%, 70%));
            --gradient-subtle: linear-gradient(180deg, hsl(0, 0%, 100%), hsl(210, 31%, 98%));
            --shadow-medium: 0 4px 20px -4px hsl(205, 78%, 60%, 0.15);
            --transition-smooth: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
        }

        body {
            background-color: var(--background);
            color: var(--foreground);
            font-family: 'Roboto', sans-serif;
            margin: 0;
            display: flex;
            justify-content: center;
            align-items: center;
            min-height: 100vh;
        }

        .container {
            max-width: 450px;
            width: 100%;
            padding: 2.5rem;
            background: var(--card);
            border: 1px solid var(--border);
            border-radius: var(--radius);
            box-shadow: var(--shadow-medium);
        }

        h2 {
            text-align: left;
            font-size: 2rem;
            font-weight: 700;
            margin-bottom: 2rem;
            color: var(--card-foreground);
        }

        input[type="text"], input[type="password"] {
            width: 100%;
            padding: 1rem 1.25rem;
            margin: 0.75rem 0;
            border: 1px solid var(--input);
            border-radius: var(--radius);
            color: var(--foreground);
            font-size: 1.1rem;
            box-sizing: border-box;
        }

        input[type="text"]:focus, input[type="password"]:focus {
            outline: none;
            border-color: var(--ring);
            box-shadow: 0 0 0 3px hsl(205, 78%, 60%, 0.1);
        }

        button {
            width: 100%;
            padding: 1rem;
            background: var(--primary);
            border: none;
            color: var(--primary-foreground);
            font-size: 1.1rem;
            font-weight: 500;
            border-radius: var(--radius);
            cursor: pointer;
            transition: var(--transition-smooth);
        }

        button:hover {
            background: hsl(205, 78%, 50%);
        }

        p {
            text-align: left;
            margin-top: 1.5rem;
        }

        a {
            color: var(--primary);
            text-decoration: none;
            transition: var(--transition-smooth);
        }

        a:hover {
            color: hsl(205, 78%, 50%);
        }
    </style>
</head>
<body>
    <div class="container">
        <h2>Login</h2>
        <%
            if ("1".equals(request.getParameter("error"))) {
                out.println("<p style='color:red;'>Invalid email or password. Please try again.</p>");
            }
        %>
        <form action="login" method="post">
            <input type="text" name="email" placeholder="Enter Email" required>
            <input type="password" name="password" placeholder="Enter Password" required>
            <button type="submit">Login</button>
        </form>
        <p><a href="register.jsp">Register Here</a></p>
    </div>
</body>
</html>