package api

import (
	"encoding/json"
	"github.com/julienschmidt/httprouter"
	"net/http"
	"onlineCustomerCare/entity"
	"onlineCustomerCare/service"
	"strconv"
)

type serviceapi struct{
	servService Service.ServiceService
}
func NewServiceApi (serviceServ Service.ServiceService)*serviceapi{
	return &serviceapi{servService:serviceServ}
}
//Get service TO api
func (uh *serviceapi) GetServices(w http.ResponseWriter, r *http.Request) {
	w.Header().Set("Content-Type", "application/json")

	users,_ := uh.servService.Services()
	_ = json.NewEncoder(w).Encode(users)

}
func (uh *serviceapi) FindService(w http.ResponseWriter, r *http.Request,ps httprouter.Params) {

	w.Header().Set("Content-Type","application/json")
	users,_ := uh.servService.Services()

	id,_ := strconv.Atoi(ps.ByName("id"))

	for _,u := range  users{
		if (u.ID) == id {
			_ = json.NewEncoder(w).Encode(u)
		}
	}



}

func (uh *serviceapi) PostService(w http.ResponseWriter, r *http.Request) {
	var u entity.Service

	w.Header().Set("Content-Type","application/json")
	_ = json.NewDecoder(r.Body).Decode(&u)
	uh.servService.StoreService(&u)

}
func (uh *serviceapi) PutService(w http.ResponseWriter, r *http.Request,ps httprouter.Params) {
	w.Header().Set("Content-Type","application/json")

	id,_ := strconv.Atoi(ps.ByName("id"))
	u,_ := uh.servService.ServiceById(id)
	_ = json.NewDecoder(r.Body).Decode(&u)
	updated,_ := uh.servService.UpdateService(u)
	_ = json.NewEncoder(w).Encode(updated)


}
func (uh *serviceapi) DeleteService(w http.ResponseWriter, r *http.Request,ps httprouter.Params) {
	w.Header().Set("Content-Type","application/json")

	id,_ := strconv.Atoi(ps.ByName("id"))
	uh.servService.DeleteService(int(id))
}
