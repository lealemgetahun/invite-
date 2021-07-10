package main

import (
	"fmt"
	"github.com/julienschmidt/httprouter"
	"log"
	"onlineCustomerCare/comment/commentRepository"
	"onlineCustomerCare/comment/commentService"
	"onlineCustomerCare/company/companyRepository"
	"onlineCustomerCare/company/companyService"
	"onlineCustomerCare/delivery/http/api"
	"onlineCustomerCare/entity"
	"onlineCustomerCare/service/ServiceRepository"
	"onlineCustomerCare/service/ServiceService"
	"onlineCustomerCare/service_and_company/sacRepository"
	"onlineCustomerCare/service_and_company/sacService"
	"onlineCustomerCare/user/userRepository"
	"onlineCustomerCare/user/userService"
	//"time"
	_ "github.com/jinzhu/gorm/dialects/postgres"

	//"github.com/gorilla/mux"
	//"github.com/gorilla/mux"
	"net/http"

	"github.com/jinzhu/gorm"
)


func createTables(dbconn *gorm.DB) []error {
	errs := dbconn.CreateTable(&entity.Company_vs_service{}).GetErrors()
	if errs != nil {
		return errs
	}
	return nil
}

func main() {



	connStr := fmt.Sprintf("postgres://%s:%s@%s/%s?sslmode=disable", "postgres",
		"lealem-g","localhost", "customercare")

	dbconn, err := gorm.Open("postgres", connStr)
	//createTables(dbconn)
	if err != nil  {
		panic(err)
	}
	
		defer dbconn.Close()
//
	userRepo := userRepository.NewUserGormRepo(dbconn)
	userServ := userService.NewUserService(userRepo)

	compRepo := companyRepository.NewCompanyGormRepo(dbconn)
	compserv := companyService.NewCompanyService(compRepo)

	commentRepo := commentRepository.NewCommentGormRepo(dbconn)
	commentserv := commentService.NewCommentService(commentRepo)

	servRepo := ServiceRepository.NewServiceGormRepo(dbconn)
	servServ := ServiceService.NewServiceService(servRepo)

	sacRepo := sacRepository.NewSacGormREpo(dbconn)
	sacServ := sacService.NewSacService(sacRepo)
	
	userapi := api.NewUserApi(userServ)
	compapi := api.NewCompanyApi(compserv)
	commentapi := api.NewCommentApi(commentserv)
	serviceapi := api.NewServiceApi(servServ)
	sacapi := api.NewSacApi(sacServ,servServ,compserv)
  
//##############################################mulriplexer and http handle functions######################################################################

	//r := mux.NewRouter()
	r := httprouter.New()

	//Handle User
	r.HandlerFunc("GET","/users",userapi.GetUsers)
	r.GET("/users/:id",userapi.FindUser)
	r.PUT("/users/:id",userapi.PutUser)
	r.DELETE("/users/:id",userapi.DeleteUser)
	r.HandlerFunc("POST","/users",userapi.PostUser)
	r.HandlerFunc("POST","/login",userapi.Login)

	//Handle Company
	r.HandlerFunc("GET","/companies",compapi.GetCompanies)
	r.GET("/companies/:id",compapi.FindCompany)
	r.PUT("/companies/:id",compapi.PutCompany)
	r.DELETE("/companies/:id",compapi.DeleteCompany)
	r.HandlerFunc("POST","/companies",compapi.PostCompany)

	//Handle Comment
	r.HandlerFunc("GET","/comments",commentapi.GetComments)
	r.GET("/comments/:id",commentapi.FindComment)
	r.PUT("/comments/:id",commentapi.PutComment)
	r.DELETE("/comments/:id",commentapi.DeleteComment)
	r.HandlerFunc("POST","/comments",commentapi.PostComment)

	//Handle Service
	r.HandlerFunc("GET","/services",serviceapi.GetServices)
	r.GET("/services/:id",serviceapi.FindService)
	r.PUT("/services/:id",serviceapi.PutService)
	r.DELETE("/services/:id",serviceapi.DeleteService)
	r.HandlerFunc("POST","/services",serviceapi.PostService)

	//handle relationship between service and company
	r.GET("/searchByComp/:id",sacapi.SearchByCompany)
	r.GET("/searchByServ/:id",sacapi.SearchByService)

	log.Fatal(http.ListenAndServe(":8282",r))


}



