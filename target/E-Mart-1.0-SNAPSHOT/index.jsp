<%@page import="com.mycompany.e.mart.helper.FactoryProvider"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%@include file="components/common_css_js.jsp"%>
<%@include file="components/navbar.jsp"%>

<div class="container mt-4">

    <h1>Welcome to E-Mart</h1>

    <h2>Testing Hibernate Connection</h2>

    <%
        try{
            out.println("SessionFactory : " + FactoryProvider.getFactory());
        }catch(Exception e){
            out.println(e.getMessage());
        }
    %>

</div>