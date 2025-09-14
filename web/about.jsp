<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>About Us - Mk mart</title>
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
        .content-block { background-color: var(--card); border: 1px solid var(--border); border-radius: var(--radius); padding: 2.5rem; margin-bottom: 2rem; }
        .content-block h2 { font-size: 2rem; font-weight: 600; margin-bottom: 1.25rem; color: var(--foreground); }
        .content-block p { font-size: 1.2rem; line-height: 1.8; color: var(--foreground); }
    </style>
</head>
<body>
    <%@ include file="header.jsp" %>

    <div class="container">
        <h1 class="section-title">About Mk mart</h1>

        <div class="content-block">
            <h2>Our Mission</h2>
            <p>At Mk mart, our mission is to provide cutting-edge technology products that enhance the daily lives of our customers. We believe in offering a curated selection of high-quality electronics, smart home devices, and accessories that combine innovation with exceptional design.</p>
        </div>

        <div class="content-block">
            <h2>Our Vision</h2>
            <p>We envision a future where technology seamlessly integrates into every aspect of life, making it simpler, smarter, and more enjoyable. Elite Store aims to be at the forefront of this transformation, constantly seeking out the next big thing to bring to your doorstep.</p>
        </div>

        <div class="content-block">
            <h2>Why Choose Us?</h2>
            <p><strong>Quality Assurance:</strong> Every product in our store is meticulously selected and tested to ensure it meets our high standards of quality and performance.</p>
            <p><strong>Customer Focus:</strong> Your satisfaction is our top priority. We are committed to providing excellent customer service and support, from pre-purchase inquiries to after-sales assistance.</p>
            <p><strong>Innovation:</strong> We stay ahead of the curve, bringing you the latest and most innovative products on the market.</p>
            <p><strong>Secure Shopping:</strong> Shop with confidence knowing that your personal information and transactions are protected with the highest level of security.</p>
        </div>

        <div class="content-block">
            <h2>Our Team</h2>
            <p>We are a passionate team of technology enthusiasts dedicated to bringing you the best products and an unparalleled shopping experience. Our experts are always on hand to provide advice and support, ensuring you make the perfect choice for your needs.</p>
        </div>
    </div>
</body>
</html>
