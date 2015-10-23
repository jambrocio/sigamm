package pe.com.sigamm.session;

import javax.servlet.annotation.WebListener;
import javax.servlet.http.HttpSessionEvent;
import javax.servlet.http.HttpSessionListener;

import org.springframework.beans.factory.annotation.Autowired;

import pe.com.sigamm.controller.LoginController;

@WebListener
public class SessionListener implements HttpSessionListener{
	
	@Autowired
	LoginController loginController;
	
	@Override
	public void sessionCreated(HttpSessionEvent event) {
		System.out.println("==== Session is created ====");
		
		int sessionTimeOut = 30;		//30 minutos
		event.getSession().setMaxInactiveInterval(sessionTimeOut * 60);
		
	}
	
	@Override
	public void sessionDestroyed(HttpSessionEvent event) {
		System.out.println("==== Session is destroyed ====");
		
	}
}
