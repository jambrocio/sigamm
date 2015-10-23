package pe.com.sigamm.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import pe.com.sigamm.session.DatosSession;

public class RequestProcessingTimeInterceptor extends HandlerInterceptorAdapter{
	
	private static final Logger log = Logger.getLogger(RequestProcessingTimeInterceptor.class);
	
	@Autowired
	private DatosSession datosSession;
	
	@Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
    	
        //long startTime = System.currentTimeMillis();
        //log.info("Request URL::" + request.getRequestURL().toString() + ":: Start Time=" + System.currentTimeMillis());
        //request.setAttribute("startTime", startTime);
        //if returned false, we need to make sure 'response' is sent
        
        String usuario = datosSession.getUsuario() != null ? datosSession.getUsuario().toUpperCase() : "";
        String reqURI = request.getRequestURI();
        if(usuario.equals("") && reqURI.indexOf("/logout") == -1){
        	
        	response.sendRedirect(request.getContextPath() + "/logout");
        	
        }
        
        return true;
        
    }
 
    @Override
    public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler,
            ModelAndView modelAndView) throws Exception {
        
    	//System.out.println("Request URL::" + request.getRequestURL().toString() + " Sent to Handler :: Current Time=" + System.currentTimeMillis());
        //we can add attributes in the modelAndView and use that in the view page
    }
 
    @Override
    public void afterCompletion(HttpServletRequest request, HttpServletResponse response, Object handler, Exception ex)
            throws Exception {
    	
    	/*
        long startTime = (Long) request.getAttribute("startTime");
        log.info("Request URL::" + request.getRequestURL().toString() + ":: End Time=" + System.currentTimeMillis());
        log.info("Request URL::" + request.getRequestURL().toString() + ":: Time Taken=" + (System.currentTimeMillis() - startTime));
       	*/
    }
}
