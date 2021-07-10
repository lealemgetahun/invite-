package comment

import "onlineCustomerCare/entity"

// CommentService specifies customer comment related service
type CommentService interface {
	Comments() ([]entity.Comment, []error)
	Comment(id uint) (*entity.Comment, []error)
	UpdateComment(user *entity.Comment) (*entity.Comment, []error)
	DeleteComment(id uint) (*entity.Comment, []error)
	StoreComment(comment *entity.Comment) (*entity.Comment, []error)
}