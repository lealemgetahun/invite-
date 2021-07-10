package api

import (
	"encoding/json"
	"github.com/julienschmidt/httprouter"
	"net/http"
	"onlineCustomerCare/entity"
	"onlineCustomerCare/session"
	"strconv"
	"time"

	//"onlineCustomerCare/entity"
	"onlineCustomerCare/user"
)
type userapi struct{
	userService user.UserService
}
func NewUserApi (userServ user.UserService)*userapi{
	return &userapi{userService:userServ}
}
//Get user TO api
func (uh *userapi) GetUsers(w http.ResponseWriter, r *http.Request) {
	w.Header().Set("Content-Type", "application/json")
	users,_ := uh.userService.Users()
	_ = json.NewEncoder(w).Encode(users)

}
func (uh *userapi) FindUser(w http.ResponseWriter, r *http.Request,ps httprouter.Params) {

	w.Header().Set("Content-Type","application/json")
	users,_ := uh.userService.Users()

	id,_ := strconv.Atoi(ps.ByName("id"))

	for _,u := range  users{
		if (u.ID) == id {
			_ = json.NewEncoder(w).Encode(u)
		}
	}



}

func (uh *userapi) PostUser(w http.ResponseWriter, r *http.Request) {
	var u entity.User

	w.Header().Set("Content-Type","application/json")
	_ = json.NewDecoder(r.Body).Decode(&u)
	uh.userService.StoreUser(&u)
	_ = json.NewEncoder(w).Encode(u)

}
func (uh *userapi) PutUser(w http.ResponseWriter, r *http.Request,ps httprouter.Params) {
	w.Header().Set("Content-Type","application/json")

	id,_ := strconv.Atoi(ps.ByName("id"))
	u,_ := uh.userService.User(id)
	_ = json.NewDecoder(r.Body).Decode(&u)
	updated,_ := uh.userService.UpdateUser(u)
	_ = json.NewEncoder(w).Encode(updated)


}
func (uh *userapi) DeleteUser(w http.ResponseWriter, r *http.Request,ps httprouter.Params) {
	w.Header().Set("Content-Type","application/json")

	id,_ := strconv.Atoi(ps.ByName("id"))
	uh.userService.DeleteUser(uint(id))

}
func (uh *userapi) Login(w http.ResponseWriter, r *http.Request){
	var u entity.Login

	w.Header().Set("Content-Type","application/json")
	_ = json.NewDecoder(r.Body).Decode(&u)
	userData,_ := uh.userService.Users()

	tokenString, err := session.Generate(u.Username)
	if err != nil {
		return
	}
	http.SetCookie(w, &http.Cookie{
		Name:  "token",
		Value: tokenString,
	})
	var i = 0
	if(u.Username == "admin" && u.Password == "adminpass"){
		_ = json.NewEncoder(w).Encode("admin")
		i++
	}
	
	for _,us := range userData{
		
		if us.Username == u.Username && us.Password == u.Password{
			_ = json.NewEncoder(w).Encode(us)
			i++
			
		}
	}
	if i != 1 {
		http.Error(w, http.StatusText(http.StatusBadRequest), http.StatusBadRequest)
	}
	
}

func (uh *userapi) Logout(w http.ResponseWriter, r *http.Request) {

	c := http.Cookie{
		Name:    "token",
		MaxAge:  -1,
		Expires: time.Unix(1, 0),
		Value:   "",
	}
	http.SetCookie(w, &c)


}
