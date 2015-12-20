package pe.com.sigamm.modelo; 


public class LuzOriginal {
	
	int codigoReciboLuzOriginal;
	String periodo;
	String fecVencimiento;
	String fecEmision;
	double costoWats;
	int estado;
	double repoManCnx;
	double cargoFijo;
	double alumbradoPublico;
	double alumbradoPublicoOriginal;
	double subTotalMes;
	double igv;
	double totalMesAct;
	double aporteLey;
	double deudaAnterior;
	double redonMesAct;
	double redonMesAnt;
	double recargoMora;
	double total;
	double mantenimiento;
	double interesCompensatorio;
	double energActFraPtaActual;	
	double energActFraPtaAnteri;
	double energActFraPtaDifer;
	double energActFraPtaFactor;
	double energActFraPtaConsu;
	double energActFraPtaConfa;
	double energActFraPtaPreuni;
	double energActFraPtaTotal;
	double energActHorPtaActu;
	double energActHorPtaAnt;
	double energActHorPtaDif;
	double energActHorPtaFac;
	double energActHorPtaCons;
	double energActHorPtaConfac;
	double energActHorPtaPreuni;
	double energActHorPtaTotal;
	double energReacInicial;
	double energReacAnteri;
	double energReacDifere;
	double energReacFactor;
	double energReacConsu;
	double energReacFaccons;
	double energReacPreuni;
	double energReacTotal;
	double potenciaFpIni;
	double potenciaFpAnte;
	double potenciaFpDif;
	double potenciaFpFac;
	double potenciaFpCons;
	double potenciaHpAct;
	double potenciaHpAnt;
	double potenciaHpDif;
	double potenciaHpFac;
	double potenciaHpCons;
	double potUsoRedDistConfac;
	double potUsoRedDistPreuni;
	double potGenFpConfac;
	double potGenFpPreuni;
	double potUsoRedDistTotal;
	double potGenFpTotal;
	double ajustePrecioRetroactivo;
	double igvRefact;
	
	public String getPeriodo() {
		return periodo;
	}
	public void setPeriodo(String periodo) {
		this.periodo = periodo;
	}
	public String getFecVencimiento() {
		return fecVencimiento;
	}
	public void setFecVencimiento(String fecVencimiento) {
		this.fecVencimiento = fecVencimiento;
	}
	public String getFecEmision() {
		return fecEmision;
	}
	public void setFecEmision(String fecEmision) {
		this.fecEmision = fecEmision;
	}
	public double getCostoWats() {
		return costoWats;
	}
	public void setCostoWats(double costoWats) {
		this.costoWats = costoWats;
	}
	public int getEstado() {
		return estado;
	}
	public void setEstado(int estado) {
		this.estado = estado;
	}
	public double getRepoManCnx() {
		return repoManCnx;
	}
	public void setRepoManCnx(double repoManCnx) {
		this.repoManCnx = repoManCnx;
	}
	public double getCargoFijo() {
		return cargoFijo;
	}
	public void setCargoFijo(double cargoFijo) {
		this.cargoFijo = cargoFijo;
	}
	public double getSubTotalMes() {
		return subTotalMes;
	}
	public void setSubTotalMes(double subTotalMes) {
		this.subTotalMes = subTotalMes;
	}
	public double getIgv() {
		return igv;
	}
	public void setIgv(double igv) {
		this.igv = igv;
	}
	public double getTotalMesAct() {
		return totalMesAct;
	}
	public void setTotalMesAct(double totalMesAct) {
		this.totalMesAct = totalMesAct;
	}
	public double getAporteLey() {
		return aporteLey;
	}
	public void setAporteLey(double aporteLey) {
		this.aporteLey = aporteLey;
	}
	public double getRedonMesAct() {
		return redonMesAct;
	}
	public void setRedonMesAct(double redonMesAct) {
		this.redonMesAct = redonMesAct;
	}
	public double getRedonMesAnt() {
		return redonMesAnt;
	}
	public void setRedonMesAnt(double redonMesAnt) {
		this.redonMesAnt = redonMesAnt;
	}
	public double getEnergActFraPtaActual() {
		return energActFraPtaActual;
	}
	public void setEnergActFraPtaActual(double energActFraPtaActual) {
		this.energActFraPtaActual = energActFraPtaActual;
	}
	public double getEnergActFraPtaAnteri() {
		return energActFraPtaAnteri;
	}
	public void setEnergActFraPtaAnteri(double energActFraPtaAnteri) {
		this.energActFraPtaAnteri = energActFraPtaAnteri;
	}
	public double getEnergActFraPtaDifer() {
		return energActFraPtaDifer;
	}
	public void setEnergActFraPtaDifer(double energActFraPtaDifer) {
		this.energActFraPtaDifer = energActFraPtaDifer;
	}
	public double getEnergActFraPtaFactor() {
		return energActFraPtaFactor;
	}
	public void setEnergActFraPtaFactor(double energActFraPtaFactor) {
		this.energActFraPtaFactor = energActFraPtaFactor;
	}
	public double getEnergActFraPtaConsu() {
		return energActFraPtaConsu;
	}
	public void setEnergActFraPtaConsu(double energActFraPtaConsu) {
		this.energActFraPtaConsu = energActFraPtaConsu;
	}
	public double getEnergActFraPtaConfa() {
		return energActFraPtaConfa;
	}
	public void setEnergActFraPtaConfa(double energActFraPtaConfa) {
		this.energActFraPtaConfa = energActFraPtaConfa;
	}
	public double getEnergActFraPtaPreuni() {
		return energActFraPtaPreuni;
	}
	public void setEnergActFraPtaPreuni(double energActFraPtaPreuni) {
		this.energActFraPtaPreuni = energActFraPtaPreuni;
	}
	public double getEnergActFraPtaTotal() {
		return energActFraPtaTotal;
	}
	public void setEnergActFraPtaTotal(double energActFraPtaTotal) {
		this.energActFraPtaTotal = energActFraPtaTotal;
	}
	public double getEnergActHorPtaActu() {
		return energActHorPtaActu;
	}
	public void setEnergActHorPtaActu(double energActHorPtaActu) {
		this.energActHorPtaActu = energActHorPtaActu;
	}
	public double getEnergActHorPtaAnt() {
		return energActHorPtaAnt;
	}
	public void setEnergActHorPtaAnt(double energActHorPtaAnt) {
		this.energActHorPtaAnt = energActHorPtaAnt;
	}
	public double getEnergActHorPtaDif() {
		return energActHorPtaDif;
	}
	public void setEnergActHorPtaDif(double energActHorPtaDif) {
		this.energActHorPtaDif = energActHorPtaDif;
	}
	public double getEnergActHorPtaFac() {
		return energActHorPtaFac;
	}
	public void setEnergActHorPtaFac(double energActHorPtaFac) {
		this.energActHorPtaFac = energActHorPtaFac;
	}
	public double getEnergActHorPtaCons() {
		return energActHorPtaCons;
	}
	public void setEnergActHorPtaCons(double energActHorPtaCons) {
		this.energActHorPtaCons = energActHorPtaCons;
	}
	public double getEnergActHorPtaConfac() {
		return energActHorPtaConfac;
	}
	public void setEnergActHorPtaConfac(double energActHorPtaConfac) {
		this.energActHorPtaConfac = energActHorPtaConfac;
	}
	public double getEnergActHorPtaPreuni() {
		return energActHorPtaPreuni;
	}
	public void setEnergActHorPtaPreuni(double energActHorPtaPreuni) {
		this.energActHorPtaPreuni = energActHorPtaPreuni;
	}
	public double getEnergActHorPtaTotal() {
		return energActHorPtaTotal;
	}
	public void setEnergActHorPtaTotal(double energActHorPtaTotal) {
		this.energActHorPtaTotal = energActHorPtaTotal;
	}
	public double getEnergReacInicial() {
		return energReacInicial;
	}
	public void setEnergReacInicial(double energReacInicial) {
		this.energReacInicial = energReacInicial;
	}
	public double getEnergReacAnteri() {
		return energReacAnteri;
	}
	public void setEnergReacAnteri(double energReacAnteri) {
		this.energReacAnteri = energReacAnteri;
	}
	public double getEnergReacDifere() {
		return energReacDifere;
	}
	public void setEnergReacDifere(double energReacDifere) {
		this.energReacDifere = energReacDifere;
	}
	public double getEnergReacFactor() {
		return energReacFactor;
	}
	public void setEnergReacFactor(double energReacFactor) {
		this.energReacFactor = energReacFactor;
	}
	public double getEnergReacConsu() {
		return energReacConsu;
	}
	public void setEnergReacConsu(double energReacConsu) {
		this.energReacConsu = energReacConsu;
	}
	public double getEnergReacFaccons() {
		return energReacFaccons;
	}
	public void setEnergReacFaccons(double energReacFaccons) {
		this.energReacFaccons = energReacFaccons;
	}
	public double getEnergReacPreuni() {
		return energReacPreuni;
	}
	public void setEnergReacPreuni(double energReacPreuni) {
		this.energReacPreuni = energReacPreuni;
	}
	public double getEnergReacTotal() {
		return energReacTotal;
	}
	public void setEnergReacTotal(double energReacTotal) {
		this.energReacTotal = energReacTotal;
	}
	public double getPotenciaFpIni() {
		return potenciaFpIni;
	}
	public void setPotenciaFpIni(double potenciaFpIni) {
		this.potenciaFpIni = potenciaFpIni;
	}
	public double getPotenciaFpAnte() {
		return potenciaFpAnte;
	}
	public void setPotenciaFpAnte(double potenciaFpAnte) {
		this.potenciaFpAnte = potenciaFpAnte;
	}
	public double getPotenciaFpDif() {
		return potenciaFpDif;
	}
	public void setPotenciaFpDif(double potenciaFpDif) {
		this.potenciaFpDif = potenciaFpDif;
	}
	public double getPotenciaFpFac() {
		return potenciaFpFac;
	}
	public void setPotenciaFpFac(double potenciaFpFac) {
		this.potenciaFpFac = potenciaFpFac;
	}
	public double getPotenciaFpCons() {
		return potenciaFpCons;
	}
	public void setPotenciaFpCons(double potenciaFpCons) {
		this.potenciaFpCons = potenciaFpCons;
	}
	public double getPotenciaHpAct() {
		return potenciaHpAct;
	}
	public void setPotenciaHpAct(double potenciaHpAct) {
		this.potenciaHpAct = potenciaHpAct;
	}
	public double getPotenciaHpAnt() {
		return potenciaHpAnt;
	}
	public void setPotenciaHpAnt(double potenciaHpAnt) {
		this.potenciaHpAnt = potenciaHpAnt;
	}
	public double getPotenciaHpDif() {
		return potenciaHpDif;
	}
	public void setPotenciaHpDif(double potenciaHpDif) {
		this.potenciaHpDif = potenciaHpDif;
	}
	public double getPotenciaHpFac() {
		return potenciaHpFac;
	}
	public void setPotenciaHpFac(double potenciaHpFac) {
		this.potenciaHpFac = potenciaHpFac;
	}
	public double getPotenciaHpCons() {
		return potenciaHpCons;
	}
	public void setPotenciaHpCons(double potenciaHpCons) {
		this.potenciaHpCons = potenciaHpCons;
	}
	public double getPotUsoRedDistConfac() {
		return potUsoRedDistConfac;
	}
	public void setPotUsoRedDistConfac(double potUsoRedDistConfac) {
		this.potUsoRedDistConfac = potUsoRedDistConfac;
	}
	public double getPotUsoRedDistPreuni() {
		return potUsoRedDistPreuni;
	}
	public void setPotUsoRedDistPreuni(double potUsoRedDistPreuni) {
		this.potUsoRedDistPreuni = potUsoRedDistPreuni;
	}
	public double getPotGenFpConfac() {
		return potGenFpConfac;
	}
	public void setPotGenFpConfac(double potGenFpConfac) {
		this.potGenFpConfac = potGenFpConfac;
	}
	public double getPotUsoRedDistTotal() {
		return potUsoRedDistTotal;
	}
	public void setPotUsoRedDistTotal(double potUsoRedDistTotal) {
		this.potUsoRedDistTotal = potUsoRedDistTotal;
	}
	public double getPotGenFpTotal() {
		return potGenFpTotal;
	}
	public void setPotGenFpTotal(double potGenFpTotal) {
		this.potGenFpTotal = potGenFpTotal;
	}
	public int getCodigoReciboLuzOriginal() {
		return codigoReciboLuzOriginal;
	}
	public void setCodigoReciboLuzOriginal(int codigoReciboLuzOriginal) {
		this.codigoReciboLuzOriginal = codigoReciboLuzOriginal;
	}
	public double getDeudaAnterior() {
		return deudaAnterior;
	}
	public void setDeudaAnterior(double deudaAnterior) {
		this.deudaAnterior = deudaAnterior;
	}
	public double getRecargoMora() {
		return recargoMora;
	}
	public void setRecargoMora(double recargoMora) {
		this.recargoMora = recargoMora;
	}
	public double getInteresCompensatorio() {
		return interesCompensatorio;
	}
	public void setInteresCompensatorio(double interesCompensatorio) {
		this.interesCompensatorio = interesCompensatorio;
	}
	public double getAlumbradoPublico() {
		return alumbradoPublico;
	}
	public void setAlumbradoPublico(double alumbradoPublico) {
		this.alumbradoPublico = alumbradoPublico;
	}
	public double getPotGenFpPreuni() {
		return potGenFpPreuni;
	}
	public void setPotGenFpPreuni(double potGenFpPreuni) {
		this.potGenFpPreuni = potGenFpPreuni;
	}
	public double getAlumbradoPublicoOriginal() {
		return alumbradoPublicoOriginal;
	}
	public void setAlumbradoPublicoOriginal(double alumbradoPublicoOriginal) {
		this.alumbradoPublicoOriginal = alumbradoPublicoOriginal;
	}
	public double getTotal() {
		return total;
	}
	public void setTotal(double total) {
		this.total = total;
	}
	public double getMantenimiento() {
		return mantenimiento;
	}
	public void setMantenimiento(double mantenimiento) {
		this.mantenimiento = mantenimiento;
	}
	public double getAjustePrecioRetroactivo() {
		return ajustePrecioRetroactivo;
	}
	public void setAjustePrecioRetroactivo(double ajustePrecioRetroactivo) {
		this.ajustePrecioRetroactivo = ajustePrecioRetroactivo;
	}
	public double getIgvRefact() {
		return igvRefact;
	}
	public void setIgvRefact(double igvRefact) {
		this.igvRefact = igvRefact;
	}
	
}
