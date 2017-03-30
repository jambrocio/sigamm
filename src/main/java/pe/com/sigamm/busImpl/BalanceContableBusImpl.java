package pe.com.sigamm.busImpl;

import javax.annotation.Resource;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Service;

import com.google.gson.Gson;

import pe.com.sigamm.bus.BalanceContableBus;
import pe.com.sigamm.dao.BalanceContableDao;
import pe.com.sigamm.modelo.BalanceContable;
import pe.com.sigamm.modelo.Retorno;

@Service
public class BalanceContableBusImpl implements BalanceContableBus {

	Gson gson = new Gson();
	private static final Logger log = Logger.getLogger(FacturacionBusImpl.class);
	
	@Resource
	private BalanceContableDao balanceContableDao;
	
	@Override
	public Retorno BuscarBalanceContable(BalanceContable balanceContable) {
		
		return balanceContableDao.BuscarBalanceContable(balanceContable);

	}
	
	

}
