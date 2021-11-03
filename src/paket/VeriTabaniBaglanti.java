package paket;

import java.math.BigInteger;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.Statement;
import java.text.SimpleDateFormat;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.Date;
import java.util.Properties;
import java.util.concurrent.TimeUnit;

import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

public class VeriTabaniBaglanti {
	Connection Baglanti;
	Statement Stm;
	ResultSet Rs;
	CallableStatement Cs;
	
	public VeriTabaniBaglanti() {
		try {
			Baglanti= DriverManager.getConnection("jdbc:sqlserver://DORUK57\\SQLEXPRESSSP3;databaseName=MakaleDB;integratedSecurity=true;");
			Stm = Baglanti.createStatement();
			System.out.println("Baglandý");
			
		}
		catch(Exception e) {
			System.out.print("Baðlantý hatasý: "+e);
		}
	}
	
	
	//Giriþ
	public String[] GirisKontrol(String ad, String sifre, String alan) {
		int Count=0;
		String[] KBilgi= new String[3];
		System.out.println("Alan:"+ alan+ " Ad:"+ ad+" Sifre:"+ sifre);
		
		try {
			Rs=Stm.executeQuery("select * from "+alan+" where ad='"+ad+"' and sifre='"+sifre+"'");
			while(Rs.next()) {
				Count++;
				
				KBilgi[0]=Rs.getString("id");
				KBilgi[1]=Rs.getString("ad");
				
			 }
		}
		catch(Exception e){
			System.out.println("Sorgu hatasý: "+e.toString());
		}
		
		if(Count==1)
			KBilgi[2]="true";
		else
			KBilgi[2]="false";
		
		return KBilgi;
	}
	
	//Þifre Güncelleme
	public Boolean SifreGuncelle(String sifre, String asifre, String id, String alan) {
		String AKSifre="";
		Boolean Durum=true;
		
		try {
			 Rs=Stm.executeQuery("select * from "+alan+" where id="+id+"");
			 while(Rs.next()) {
				AKSifre=Rs.getString("sifre");
			 }
			 
			 if(asifre.equals(AKSifre)){
				 Stm.executeUpdate("update "+alan+" set sifre="+sifre+" where id="+id+"");
			 }
			 else
				 Durum=false;
		}
		catch(Exception e){
			System.out.println("Sorgu hatasý: "+e.toString());
		}
		
		return Durum;
	}	
	
	//MD5 metot
	public static String MD5Uret(String input)
    {
        try {
        	MessageDigest md = MessageDigest.getInstance("MD5");
  
            byte[] messageDigest = md.digest(input.getBytes());
  
            BigInteger no = new BigInteger(1, messageDigest);
  
            String hashtext = no.toString(16);
            while (hashtext.length() < 32) {
                hashtext = "0" + hashtext;
            }
            return hashtext;
        } 
  
        
        catch (NoSuchAlgorithmException e) {
            throw new RuntimeException(e);
        }
    }
	
	//Eposta
	public void EMail(String Alici, String Baslik, String Icerik) {
		final String username = "otomatikmail1@gmail.com";
		final String password = "otomail123oto";
		
		Properties props = new Properties();
		props.put("mail.smtp.auth", "true");
		props.put("mail.smtp.starttls.enable", "true");
		props.put("mail.smtp.host", "smtp.gmail.com");
		props.put("mail.smtp.port", "587");
		
		Session session = Session.getInstance(props, new javax.mail.Authenticator() {
			protected PasswordAuthentication getPasswordAuthentication() {
			return new PasswordAuthentication(username, password);
		}});
		
		try {
			Message message = new MimeMessage(session);
			message.setFrom(new InternetAddress(Alici));
			message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(Alici));
			message.setSubject(Baslik);
			
			message.setContent(Icerik, "text/html; charset=UTF-8");
			Transport.send(message);
						
			System.out.println("Eposta gönderildi");
			} 
		catch (MessagingException e) {
			throw new RuntimeException(e);
		}
	}
	
	
	//EpostaSifre
	public Boolean EMailGonder(String eposta, String alan){
		System.out.println("Alan:"+ alan+ " Mail:"+ eposta);
		Boolean durum=true;
		String Uid="", UAdi="", UMail="";
		
		try {
			Rs=Stm.executeQuery("select * from "+alan+" where eposta='"+eposta+"'");
			while(Rs.next()) {
				Uid=Rs.getString("id");
				UAdi=Rs.getString("ad");
				UMail=Rs.getString("eposta");
			}
			 
			if(!Uid.equals("")){
				String link="http://localhost:8080/MakaleSistemi/YeniSifre.jsp?id="+Uid+"&alan="+alan;
				
				EMail(UMail, UAdi+" Þifre Yenileme Ýsteði", "Þifre Yenileme Baðlantýsý: <a href="+link+">"+MD5Uret(UMail)+"</a>");
			}
			else
				durum=false;
		}
		catch(Exception e){
			System.out.println("Sorgu hatasý: "+e.toString());
		}
		return durum;
	}
	
	//E posta sifre guncelle
	public void SifreEposta(String Sifre, String id, String alan){
		System.out.println("id:"+id+" alan:"+alan);
		try {
				Rs=Stm.executeQuery("update "+alan+" set sifre='"+Sifre+"'where id='"+id+"'");
			}
			catch(Exception e){
				System.out.println("Sorgu hatasý: "+e.toString());
			}
		}	
	

	//Yazar Hakem Kayýt
	//Yazar kayýt
	public Boolean YazarKayit(String ad, String Sifre, String Email) {
		String[] kontrol=GirisKontrol(ad, Sifre, "yazarlar");
		Boolean durum=true;
		if(kontrol[2]=="true")
			durum=false;
		else {
			try {
				Cs=Baglanti.prepareCall("{call YazarKayit('"+ad+"','"+Sifre+"','"+Email+"')}");
				Cs.execute();
			}
			catch(Exception e){
				System.out.println("Sorgu hatasý: "+e.toString());
				
			}
		}
		return durum;
	}
	
	//Hakem kayýt
	public Boolean HakemKayit(String ad, String sifre, String tc, String alan, String mail) {
		String[] kontrol=GirisKontrol(ad, sifre, "hakemler");
		Boolean durum=true;
		if(kontrol[2]=="true")
			durum=false;
		else {
			try {
				Cs=Baglanti.prepareCall("{call HakemKayit(?,?,?,?,?)}");
				Cs.setString(1, ad);
				Cs.setString(2, sifre);
				Cs.setString(3, tc);
				Cs.setString(4, alan);
				Cs.setString(5, mail);
				
				Cs.execute();
			}
			catch(Exception e){
				System.out.println("Sorgu hatasý: "+e.toString());
				
			}
		}
		return durum;
	}
			
		
	//Yazarlar----------------------------------------------------
	
	//Anasayfa bilgiler
	public int[] DurumBilgileri(String id) {
		int[] Bilgiler= new int[3];
		String[] Durumlar= {"Beklemede", "Raporlu", "Aktif"};
		int adet=0;
			
		for(int i=0; i<3; i++)
		{
			try {
				Cs=Baglanti.prepareCall("{call MakaleGetir('"+Durumlar[i]+"', "+id+", '')}");
				Cs.execute();
				Rs = Cs.getResultSet();
				while(Rs.next()) {
					adet++;
				}
				Bilgiler[i]=adet;
				adet=0;
			}
			catch(Exception e){
				System.out.println("Sorgu hatasý: "+e.toString());
					
			}
		}
		return Bilgiler;
	}
	
	
	
	//Makale ekleme güncelleme
	public void MakaleEG(String adi, String baslik, String alanid, String yazarid, String id, String guncelle) {
		if(guncelle=="yok") {
			try {
				Cs=Baglanti.prepareCall("{call MakaleEkle(?,?,?,?,?)}");
				Cs.setString(1, baslik);
				Cs.setString(2, adi);
				Cs.setString(3, "Beklemede");
				Cs.setString(4, yazarid);
				Cs.setString(5, alanid);
				
				
				Cs.execute();
			}
			catch(Exception e){
				System.out.println("Sorgu hatasý: "+e.toString());
				
			}
		}
		else {
			try {
				Cs=Baglanti.prepareCall("{call MakaleGuncelle('"+baslik+"','"+adi+"','Beklemede','"+yazarid+"','"+alanid+"',"+id+")}");
				
				Cs.execute();
			}
			catch(Exception e){
				System.out.println("Sorgu hatasý: "+e.toString());
				
			}
		}
			
	}
	
	//Makale guncellem bilgisi
	public ResultSet MakaleBilgi(String id) {
		try {
			Cs=Baglanti.prepareCall("{call SeciliMakale("+id+")}");
			Cs.execute();
			Rs = Cs.getResultSet();
		}
		catch(Exception e){
			System.out.println("Sorgu hatasý: "+e.toString());
			
		}
		return Rs;
	}
	
	//Makale sil
	public void MakaleSil(String id) {
		try {
			Cs=Baglanti.prepareCall("{call MakaleSil("+id+")}");
			Cs.execute();
		}
		catch(Exception e){
			System.out.println("Sorgu hatasý: "+e.toString());
			
		}
	}
	
	//Alangetirme(E kullanýyor)
	public ResultSet AlanGetir() {
		try {
			Cs=Baglanti.prepareCall("{call AlanGetir}");
			Cs.execute();
			Rs = Cs.getResultSet();
		}
		catch(Exception e){
			System.out.println("Sorgu hatasý: "+e.toString());
			
		}
		return Rs;
	}
	
	
	//Makale getirme
	public ResultSet MakaleGetir(String Durum, String id, String ara) {
		try {
			if(ara=="null")
				ara="";
			
			Cs=Baglanti.prepareCall("{call MakaleGetir('"+Durum+"', "+id+", '"+ara+"')}");
			Cs.execute();
			Rs = Cs.getResultSet();
		}
		catch(Exception e){
			System.out.println("Sorgu hatasý: "+e.toString());
			
		}
		return Rs;
	}
	
	
	//Belirlibir zaman sonra sifre guncelleme
	public Boolean SifreGuncellemeKontrol() {
		Boolean durum=true;
		
		DateTimeFormatter df = DateTimeFormatter.ofPattern("dd/MM/yyyy");
		SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy");
		TimeUnit time = TimeUnit.DAYS; 
		
		LocalDateTime tarih=LocalDateTime.now();
		String bugun=String.valueOf(df.format(tarih));
		
		try {
			Cs=Baglanti.prepareCall("{call YSifreKontrolGetir}");
			Cs.execute();
			Rs = Cs.getResultSet();
			
			while(Rs.next()) {
				Date bugun_tarih = sdf.parse(bugun);
				Date son_sifre_guncelleme = sdf.parse(Rs.getString("sifre_g_tarihi"));
				
				long diff = bugun_tarih.getTime() - son_sifre_guncelleme.getTime();
				long diffrence = time.convert(diff, TimeUnit.MILLISECONDS);
				
				System.out.println("Son Þifre Güncellme Farký: "+ diffrence);
				
				if(diffrence>60) {
					durum=false;
				}
			}
		}
		catch(Exception e){
			System.out.println("Sorgu hatasý: "+e.toString());
		}
		
		return durum;
	}
	
	
	
	//Editörler-----------------------------------------------------------------
	
	//Bilgiler
	public int[] EDurumBilgileri() {
		int[] Bilgiler= new int[3];
		String[] Durumlar= {"Beklemede", "Raporlu", "Aktif"};
		int adet=0;
			
		for(int i=0; i<3; i++)
		{
			try {
				Cs=Baglanti.prepareCall("{call EMakaleGetir('"+Durumlar[i]+"', '')}");
				Cs.execute();
				Rs = Cs.getResultSet();
				while(Rs.next()) {
					adet++;
				}
				Bilgiler[i]=adet;
				adet=0;
			}
			catch(Exception e){
				System.out.println("Sorgu hatasý: "+e.toString());
					
			}
		}
		return Bilgiler;
	}

	//Beklemedeki makaleler getirme
	public ResultSet EBeklemedekiMakaleGetir(String ara) {
		try {
			if(ara=="null")
				ara="";
				
			Cs=Baglanti.prepareCall("{call EBeklemedekiMakaleGetir('"+ara+"')}");
			Cs.execute();
			Rs = Cs.getResultSet();
		}
		catch(Exception e){
			System.out.println("Sorgu hatasý: "+e.toString());
		}
		return Rs;
	}
	
	//Aktif makaleleri getirme
	public ResultSet AktfiMakaleler(String ara) {
		try {
			if(ara=="null")
				ara="";
			
			Cs=Baglanti.prepareCall("{call EAktifMakaleler('"+ara+"')}");
			Cs.execute();
			Rs = Cs.getResultSet();
		}
		catch(Exception e){
			System.out.println("Sorgu hatasý: "+e.toString());
		}
		return Rs;
	}	
	
	//Raporlu makale getirme
	public ResultSet RaporluMakaleler(String ara) {
		try {
			if(ara=="null")
				ara="";
			
			Cs=Baglanti.prepareCall("{call ERaporluMakaleGetir('"+ara+"')}");
			Cs.execute();
			Rs = Cs.getResultSet();
		}
		catch(Exception e){
			System.out.println("Sorgu hatasý: "+e.toString());
		}
		return Rs;
	}	
		
	//Alan EkleGüncelle
	public void AlanEG(String adi, String id, String guncelle) {
			if(guncelle=="yok") {
				try {
					Cs=Baglanti.prepareCall("{call AlanEkle('"+adi+"')}");
					Cs.execute();
				}
				catch(Exception e){
					System.out.println("Sorgu hatasý: "+e.toString());
					
				}
			}
			else {
				try {
					Cs=Baglanti.prepareCall("{call AlanGuncelle('"+adi+"',"+id+")}");
					Cs.execute();
				}
				catch(Exception e){
					System.out.println("Sorgu hatasý: "+e.toString());
					
				}
			}
				
		}
	
	//Alan guncellem bilgisi
	public ResultSet AlanBilgi(String id) {
		try {
			Cs=Baglanti.prepareCall("{call SeciliAlan("+id+")}");
			Cs.execute();
			Rs = Cs.getResultSet();
		}
		catch(Exception e){
			System.out.println("Sorgu hatasý: "+e.toString());
		}
			return Rs;
	}

	//Alan sil
	public void AlanSil(String id) {
		try {
			Cs=Baglanti.prepareCall("{call AlanSil("+id+")}");
			Cs.execute();
		}
		catch(Exception e){
			System.out.println("Sorgu hatasý: "+e.toString());
			
		}
	}

	//Alana göre hakem ve teklifsayýsý
	public ResultSet AlanaGoreHakemVeTeklifSayisi(String alanid) {
		try {
			Cs=Baglanti.prepareCall("{call AlanaGoreHakemVeTeklif("+alanid+")}");
			Cs.execute();
			Rs = Cs.getResultSet();
		}
		catch(Exception e){
			System.out.println("Sorgu hatasý: "+e.toString());
		}
			return Rs;
	}

	//TeklifGonder
	public void TeklifGonder(String Eid, String Hid, String Mid) {
		
		try {
			DateTimeFormatter dateFormat = DateTimeFormatter.ofPattern("dd/MM/yyyy");
			
			LocalDateTime tarihi=LocalDateTime.now();
			LocalDateTime s_tarih=tarihi.plusDays(5);
			
			Cs=Baglanti.prepareCall("{call TeklifGonder("+Eid+", "+Hid+", "+Mid+", '"+String.valueOf(dateFormat.format(s_tarih))+"')}");
			Cs.execute();
		}
		catch(Exception e){
			System.out.println("Sorgu hatasý: "+e.toString());
		}
		
		String Had="", Hemail="";
	
		try {
			Cs=Baglanti.prepareCall("{call ESeciliHakem("+Hid+")}");
			Cs.execute();
			Rs = Cs.getResultSet();
			while(Rs.next()) {
				Had=Rs.getString("ad");
				Hemail=Rs.getString("eposta");
			}
			String link="http://localhost:8080/MakaleSistemi/HAnasayfa.jsp?durum=Teklif";
			
			EMail(Hemail, Had+" Yeni Makale Teklifi", "Yeni bir makale teklifiniz bulunmaktadýr. Lütfen <a href="+link+">bu linke</a> týklayarak aktif makale tekliflerinizi iceleyiniz. 5 gün içinde bir dönüþ yapmaz sanýz teklif ret sayýlacaktýr.");
		}
		catch(Exception e){
			System.out.println("Sorgu hatasý: "+e.toString());
		}
	}
	
	
	//Teklif Süre kontrol
	public void TKontrol() {
		DateTimeFormatter df = DateTimeFormatter.ofPattern("dd/MM/yyyy");
		SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy");
		TimeUnit time = TimeUnit.DAYS; 
		
		LocalDateTime tarih=LocalDateTime.now();
		String bugun=String.valueOf(df.format(tarih));
		
		ArrayList<String> values = new ArrayList<>();
		try {
			Cs=Baglanti.prepareCall("{call ETeklifZamanKontrol('', '')}");
			Cs.execute();
			Rs = Cs.getResultSet();
			
			while(Rs.next()) {
				Date bugun_tarih = sdf.parse(bugun);
				Date veris_tarhi = sdf.parse(Rs.getString("kabultarihi"));
				
				long diff = veris_tarhi.getTime() - bugun_tarih.getTime();
				long diffrence = time.convert(diff, TimeUnit.MILLISECONDS);
				
				System.out.println("Teklif Fark: "+ diffrence);
				
				if(diffrence<0) {
					values.add(Rs.getString("makale_id"));
				}
			}
		}
		catch(Exception e){
			System.out.println("Sorgu hatasý: "+e.toString());
		}
		
		GecikmisGuncelle(values);
	}
	
	public void GecikmisGuncelle(ArrayList list) {
		try {
			for(var id: list) {
				Cs=Baglanti.prepareCall("{call ETeklifZamanKontrol("+String.valueOf(id)+", 'guncelle')}");
				Cs.execute();
			}
		} 
		catch(Exception e){
			System.out.println("Sorgu hatasý: "+e.toString());
		}
	}
	
	//Makale rapor son 7 gun kontrol
		public void RHatirlatma() {
			DateTimeFormatter df = DateTimeFormatter.ofPattern("dd/MM/yyyy");
			SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy");
			TimeUnit time = TimeUnit.DAYS; 
			
			LocalDateTime tarih=LocalDateTime.now();
			String bugun=String.valueOf(df.format(tarih));
			
			ArrayList<String> values = new ArrayList<>();
			try {
				Cs=Baglanti.prepareCall("{call ERaporZamanKontrol}");
				Cs.execute();
				Rs = Cs.getResultSet();
				
				while(Rs.next()) {
					Date bugun_tarih = sdf.parse(bugun);
					Date veris_tarhi = sdf.parse(Rs.getString("kabultarihi"));
					
					long diff = veris_tarhi.getTime() - bugun_tarih.getTime();
					long diffrence = time.convert(diff, TimeUnit.MILLISECONDS);
					
					System.out.println("Rapor Fark: "+ diffrence);
					
					if(diffrence<7) {
						values.add(Rs.getString("id"));
					}
				}
			}
			catch(Exception e){
				System.out.println("Sorgu hatasý: "+e.toString());
			}
			
			Hatirlatma(values);
		}
		
		public void Hatirlatma(ArrayList list) {
			try {
				for(var id: list) {
					try {
						String Had="", Hemail="";
						Cs=Baglanti.prepareCall("{call ESeciliHakem("+id+")}");
						Cs.execute();
						Rs = Cs.getResultSet();
						while(Rs.next()) {
							Had=Rs.getString("ad");
							Hemail=Rs.getString("eposta");
						}
						String link="http://localhost:8080/MakaleSistemi/HAnasayfa.jsp?durum=Evet";
						
						EMail(Hemail, Had+" Rapor Süresi Yaklaþýyor", "Rapor süresinin bitmesine 7 gün kalan makaleleriniz mevcut. Lütfen <a href="+link+">bu linke</a> týklayarak rapor bekleyen makalelerinizi inceleyiniz.");
					}
					catch(Exception e){
						System.out.println("Sorgu hatasý: "+e.toString());
					}
				}
			} 
			catch(Exception e){
				System.out.println("Sorgu hatasý: "+e.toString());
			}
		}
	
	
	
	
	//Hakemler-----------------------------------------------------------------
	
	//Bilgiler
	public int[] HDurumBilgileri(String id) {
		int[] Bilgiler= new int[3];
		String[] Durumlar= {"Teklif", "Evet", "Raporlu"};
		int adet=0;
				
		for(int i=0; i<3; i++)
		{
			try {
				Cs=Baglanti.prepareCall("{call HMakaleGetir('"+Durumlar[i]+"', "+id+", '')}");
				Cs.execute();
				Rs = Cs.getResultSet();
				while(Rs.next()) {
					adet++;
				}
				Bilgiler[i]=adet;
				adet=0;
			}
			catch(Exception e){
				System.out.println("Sorgu hatasý: "+e.toString());
			}
		}
			return Bilgiler;
	}


	//MakaleGeitr
	public ResultSet HMakaleGetir(String durum, String id, String ara) {
		try {
			if(ara=="null")
				ara="";
			
			Cs=Baglanti.prepareCall("{call HMakaleGetir('"+durum+"', "+id+", '"+ara+"')}");
			Cs.execute();
			Rs = Cs.getResultSet();
		}
		catch(Exception e){
			System.out.println("Sorgu hatasý: "+e.toString());
		}
		
		return Rs;
	}

	//Makale Tercih
	public void Tercih(String mid, String tercih, String tarih) {
		try {
			Cs=Baglanti.prepareCall("{call HTercih("+mid+", '"+tercih+"', '"+tarih+"')}");
			Cs.execute();
		}
		catch(Exception e){
			System.out.println("Sorgu hatasý: "+e.toString());
		}
	}

	//Rapor yukle
	public void RaporYukle(String raporad, String mid, String tid) {
		try {
			Cs=Baglanti.prepareCall("{call RaporYukle('"+raporad+"', "+mid+", "+tid+")}");
			Cs.execute();
		}
		catch(Exception e){
			System.out.println("Sorgu hatasý: "+e.toString());
		}
	}



































}
