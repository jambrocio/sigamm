package pe.com.sigamm.bus;

import pe.com.sigamm.modelo.BalanceContable;
import pe.com.sigamm.modelo.Retorno;

public interface BalanceContableBus {

	public Retorno BuscarBalanceContable(BalanceContable balanceContable);
	
}
