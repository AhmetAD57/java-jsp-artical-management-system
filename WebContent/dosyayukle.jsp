<%@page import="org.apache.catalina.connector.Response"%>
<%@ page import="java.io.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%
    String saveFile = "";
    String contentType = request.getContentType();

    if ((contentType != null) && (contentType.indexOf("multipart/form-data") >= 0)) {
        DataInputStream in = new DataInputStream(request.getInputStream());
        int formDataLength = request.getContentLength();
        byte dataBytes[] = new byte[formDataLength];
        int byteRead = 0;
        int totalBytesRead = 0;

        while (totalBytesRead < formDataLength) {
            byteRead = in.read(dataBytes, totalBytesRead, formDataLength);
            totalBytesRead += byteRead;
        }

        String file = new String(dataBytes);
        saveFile = file.substring(file.indexOf("filename=\"") + 10);
        saveFile = saveFile.substring(0, saveFile.indexOf("\n"));
        saveFile = saveFile.substring(saveFile.lastIndexOf("\\") + 1, saveFile.indexOf("\""));
        int lastIndex = contentType.lastIndexOf("=");
        String boundary = contentType.substring(lastIndex + 1, contentType.length());

        int pos;
        pos = file.indexOf("filename=\"");
        pos = file.indexOf("\n", pos) + 1;
        pos = file.indexOf("\n", pos) + 1;
        pos = file.indexOf("\n", pos) + 1;

        int boundaryLocation = file.indexOf(boundary, pos) - 4;
        int startPos = ((file.substring(0, pos)).getBytes()).length;
        int endPos = ((file.substring(0, boundaryLocation)).getBytes()).length;
        
        session.setAttribute("makale_adi", saveFile);
        
        File ff = new File("C:/Users/Doruk 57/Documents/eclipse projects/MakaleSistemi/WebContent/articals/"+ saveFile);
        FileOutputStream fileOut = new FileOutputStream(ff);
        fileOut.write(dataBytes, startPos, (endPos - startPos));
        fileOut.flush();
        fileOut.close();
        
        System.out.println("Resim durum: "+session.getAttribute("makale_guncelle"));
        
        if(session.getAttribute("makale_rapor").equals("yok")){
	        if(session.getAttribute("makale_guncelle").equals("yok"))
	        	response.sendRedirect("MakaleEkle.jsp"); 
	        else
	        	response.sendRedirect("MakaleGuncelle.jsp?id="+session.getAttribute("makale_guncelle")); 
        }
        else{
        	response.sendRedirect("RaporYukle.jsp?"+session.getAttribute("makale_rapor")); 
        }
        
	}
%>
