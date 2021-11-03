<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ page import = "java.time.format.DateTimeFormatter, java.time.LocalDateTime" %>
<jsp:useBean id="Db" class="paket.VeriTabaniBaglanti" />

<%
String mid=String.valueOf(request.getParameter("id"));
String tercih=String.valueOf(request.getParameter("tercih"));

DateTimeFormatter dateFormat = DateTimeFormatter.ofPattern("dd/MM/yyyy");

LocalDateTime k_tarihi=LocalDateTime.now();
LocalDateTime r_tarihi=k_tarihi.plusDays(21);

Db.Tercih(mid, tercih, String.valueOf(dateFormat.format(r_tarihi)));

response.sendRedirect("HAnasayfa.jsp?durum=Teklif");
%>