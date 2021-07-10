package comment

import (
	"onlineCustomerCare/entity"
)

// CommentRepository specifies customer comment related database operations
type CommentRepository interface {
	Comments() ([]entity.Comment, []error)
	StoreComment(comment *entity.Comment) (*entity.Comment, []error)
	Comment(id uint) (*entity.Comment, []error)
	UpdateComment(user *entity.Comment) (*entity.Comment,[]error)
	DeleteComment(id uint) (*entity.Comment,[]error)
}
