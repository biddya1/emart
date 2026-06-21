<%@page import="com.mycompany.e.mart.helper.FactoryProvider"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
    <title>E-Mart</title>
</head>
<body>

    <h1>Welcome to E-Mart</h1>

    <h2>Testing Hibernate Connection</h2>

    <%
        try {
            out.println("SessionFactory: " + FactoryProvider.getFactory());
        } catch(Exception e) {
            out.println("Error: " + e.getMessage());
        }
    %>

</body>
</html>