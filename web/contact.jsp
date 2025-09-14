<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Contact Us - Mk mart</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link href="https://fonts.googleapis.com/css2?family=Roboto:wght@400;500;700&display=swap" rel="stylesheet">
    <style>
        :root {
            --background: hsl(210, 36%, 96%);
            --foreground: hsl(222, 47%, 11%);
            --card: hsl(0, 0%, 100%);
            --card-foreground: hsl(222, 47%, 11%);
            --primary: hsl(205, 78%, 60%);
            --primary-foreground: hsl(0, 0%, 98%);
            --border: hsl(210, 31%, 91%);
            --input: hsl(210, 31%, 91%);
            --radius: 1rem;
        }
        body {
            background-color: var(--background);
            color: var(--foreground);
            font-family: 'Roboto', sans-serif;
            margin: 0;
        }
        .container { max-width: 1200px; margin: 0 auto; padding: 3rem 1.5rem; }
        .section-title { font-size: 2.8rem; font-weight: 700; text-align: left; margin-bottom: 2.5rem; color: var(--primary); }
        .contact-container { display: flex; flex-direction: column; gap: 2rem; }
        @media (min-width: 768px) { .contact-container { flex-direction: row; } }
        .contact-form-container { background-color: var(--card); border: 1px solid var(--border); border-radius: var(--radius); padding: 2.5rem; flex: 1; }
        .form-group { margin-bottom: 2rem; }
        .form-group label { display: block; font-weight: 500; margin-bottom: 0.75rem; }
        .form-group input[type="text"],
        .form-group input[type="email"],
        .form-group textarea {
            width: 100%;
            padding: 1rem;
            border: 1px solid var(--input);
            border-radius: var(--radius);
            font-size: 1.1rem;
            box-sizing: border-box;
        }
        .form-group textarea { resize: vertical; min-height: 150px; }
        .submit-btn { background-color: var(--primary); color: var(--primary-foreground); padding: 1.25rem 2.5rem; border: none; border-radius: var(--radius); cursor: pointer; font-size: 1.2rem; font-weight: 500; width: 100%; transition: opacity 0.3s; }
        .submit-btn:hover { opacity: 0.85; }
        .contact-info { text-align: left; flex: 1; padding: 2.5rem; background-color: var(--card); border: 1px solid var(--border); border-radius: var(--radius); }
        .contact-info p { font-size: 1.2rem; margin-bottom: 0.75rem; }
        .contact-info a { color: var(--primary); text-decoration: none; }
        .contact-info a:hover { text-decoration: underline; }
    </style>
</head>
<body>
    <%@ include file="header.jsp" %>

    <div class="container">
        <h1 class="section-title">Contact Us</h1>

        <div class="contact-container">
            <div class="contact-form-container">
                <p style="text-align: left; margin-bottom: 2rem; font-size: 1.2rem;">Have a question or need assistance? Fill out the form below and we'll get back to you as soon as possible.</p>
                <form action="#" method="post">
                    <div class="form-group">
                        <label for="name">Name</label>
                        <input type="text" id="name" name="name" required>
                    </div>
                    <div class="form-group">
                        <label for="email">Email</label>
                        <input type="email" id="email" name="email" required>
                    </div>
                    <div class="form-group">
                        <label for="subject">Subject</label>
                        <input type="text" id="subject" name="subject" required>
                    </div>
                    <div class="form-group">
                        <label for="message">Message</label>
                        <textarea id="message" name="message" required></textarea>
                    </div>
                    <button type="submit" class="submit-btn">Send Message</button>
                </form>
            </div>

            <div class="contact-info">
                <p>You can also reach us directly:</p>
                <p>Email: <a href="mailto:support@mkmart.com">support@mkmart.com</a></p>
                <p>Phone:+91 9911002233</p>
                <p>Address: 3R98+7MP, Balaram Nagar, Gunupur, Odisha 765022</p>
            </div>
        </div>
    </div>
</body>
</html>
