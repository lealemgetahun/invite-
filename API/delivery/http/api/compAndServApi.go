package api

import (
	"encoding/json"
	"github.com/julienschmidt/httprouter"
	"net/http"
	"onlineCustomerCare/service_and_company"
	"onlineCustomerCare/company"
	"onlineCustomerCare/entity"
	"onlineCustomerCare/service"
	"strconv"
)

type sacapi struct {
	sacServ service_and_company.SacService
	compService company.CompanyService
	servService Service.ServiceService


}
//NewSacApi comment
func NewSacApi (sacv service_and_company.SacService, serviceServ Service.ServiceService, compServ company.CompanyService)*sacapi{
	return &sacapi{sacServ:sacv, servService:serviceServ,compService:compServ}
}
func(sa *sacapi) SearchByService(w http.ResponseWriter, r *http.Request,ps httprouter.Params){
	w.Header().Set("Content-Type","application/json")

	var u []*entity.Companie
	id,_ := strconv.Atoi(ps.ByName("id"))
	s,_ := sa.sacServ.SearchByService(uint(id))

	for _,sac:= range s{
		var com, _ = sa.compService.Company(uint(sac.CompanyId))	
		u = append(u,com)
		
	}
	_ = json.NewEncoder(w).Encode(u)
}
func(sa *sacapi) SearchByCompany(w http.ResponseWriter, r *http.Request,ps httprouter.Params){
	w.Header().Set("Content-Type","application/json")

	var serv []entity.Service
	id,_ := strconv.Atoi(ps.ByName("id"))
	s,_ := sa.sacServ.SearchByCompany(uint(id))
	users,_ := sa.servService.Services()

	for _,u := range  users{
		for _,sac := range s{
			if(u.ID) == sac.ServiceId{
				serv= append(serv,u)
			}
		}
	
	}
	_ = json.NewEncoder(w).Encode(serv)
		
	
	
}