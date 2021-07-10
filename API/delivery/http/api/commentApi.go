package api

import (
	"encoding/json"
	"github.com/julienschmidt/httprouter"
	"net/http"
	"onlineCustomerCare/comment"
	"onlineCustomerCare/entity"
	"strconv"
)

type commentapi struct{
	commentService comment.CommentService
}

func NewCommentApi (commentServ comment.CommentService)*commentapi{
	return &commentapi{commentService:commentServ}
}
//Get user TO api
func (ca *commentapi) GetComments(w http.ResponseWriter, r *http.Request) {
	w.Header().Set("Content-Type", "application/json")
	comments,_ := ca.commentService.Comments()
	_ = json.NewEncoder(w).Encode(comments)

}
func (ca *commentapi) FindComment(w http.ResponseWriter, r *http.Request,ps httprouter.Params) {

	w.Header().Set("Content-Type","application/json")
	comments,_ := ca.commentService.Comments()

	id,_ := strconv.Atoi(ps.ByName("id"))

	for _,u := range  comments{
		if (u.ID) == uint(id) {
			_ = json.NewEncoder(w).Encode(u)
		}
	}

}

func (ca *commentapi) PostComment(w http.ResponseWriter, r *http.Request) {
	var u entity.Comment

	w.Header().Set("Content-Type","application/json")
	
	_ = json.NewDecoder(r.Body).Decode(&u)
	ca.commentService.StoreComment(&u)

}
func (ca *commentapi) PutComment(w http.ResponseWriter, r *http.Request,ps httprouter.Params) {
	w.Header().Set("Content-Type","application/json")

	id,_ := strconv.Atoi(ps.ByName("id"))
	u,_ := ca.commentService.Comment(uint(id))
	_ = json.NewDecoder(r.Body).Decode(&u)
	updated,_ := ca.commentService.UpdateComment(u)
	_ = json.NewEncoder(w).Encode(updated)


}
func (ca *commentapi) DeleteComment(w http.ResponseWriter, r *http.Request,ps httprouter.Params) {
	w.Header().Set("Content-Type","application/json")

	id,_ := strconv.Atoi(ps.ByName("id"))
	ca.commentService.DeleteComment(uint(id))
}