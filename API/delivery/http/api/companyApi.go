package api

import (
	"encoding/json"
	"github.com/julienschmidt/httprouter"
	"net/http"
	"onlineCustomerCare/company"
	"onlineCustomerCare/entity"
	"strconv"
)

type Companyapi struct{
	compService company.CompanyService
}
func NewCompanyApi (compServ company.CompanyService)*Companyapi{
	return &Companyapi{compService:compServ}
}
//Get company TO api
func (ca *Companyapi) GetCompanies(w http.ResponseWriter, r *http.Request) {
	w.Header().Set("Content-Type", "application/json")

	companys,_ := ca.compService.Companies()
	_ = json.NewEncoder(w).Encode(companys)

}
func (ca *Companyapi) FindCompany(w http.ResponseWriter, r *http.Request,ps httprouter.Params) {

	w.Header().Set("Content-Type","application/json")
	companys,_ := ca.compService.Companies()
	id,_ := strconv.Atoi(ps.ByName("id"))

	for _,c := range  companys{
		if (c.ID) == id {
			_ = json.NewEncoder(w).Encode(c)
		}
	}



}

func (ca *Companyapi) PostCompany(w http.ResponseWriter, r *http.Request) {
	var c entity.Companie

	w.Header().Set("Content-Type","application/json")
	_ = json.NewDecoder(r.Body).Decode(&c)

	ca.compService.StoreCompany(&c)

}
func (ca *Companyapi) PutCompany(w http.ResponseWriter, r *http.Request,ps httprouter.Params) {
	w.Header().Set("Content-Type","application/json")

	id,_ := strconv.Atoi(ps.ByName("id"))
	c,_ := ca.compService.Company(uint(id))
	_ = json.NewDecoder(r.Body).Decode(&c)
	updated,_ := ca.compService.UpdateCompany(c)
	_ = json.NewEncoder(w).Encode(updated)


}
func (ca *Companyapi) DeleteCompany(w http.ResponseWriter, r *http.Request,ps httprouter.Params) {
	w.Header().Set("Content-Type","application/json")

	id,_ := strconv.Atoi(ps.ByName("id"))
	ca.compService.DeleteCompany(uint(id))
}



