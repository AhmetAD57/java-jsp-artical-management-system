<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<jsp:useBean id="Db" class="paket.VeriTabaniBaglanti" />
<%

String id=request.getParameter("id"); 

Db.AlanSil(id);


response.sendRedirect("EAnasayfa.jsp?durum=Alanlar");
%>