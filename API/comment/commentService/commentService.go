package commentService

import ("onlineCustomerCare/comment"
		"onlineCustomerCare/entity"
)

// CommentService implements comment.CommentService interface
type CommentService struct {
	commentRepo comment.CommentRepository
}

// NewCommentService returns a new CommentService object
func NewCommentService(commRepo comment.CommentRepository) comment.CommentService {
	return &CommentService{commentRepo: commRepo}
}

// Comments returns all stored comments
func (cs *CommentService) Comments() ([]entity.Comment, []error) {
	cmnts, errs := cs.commentRepo.Comments()
	if len(errs) > 0 {
		return nil, errs
	}
	return cmnts, errs
}
// Comment retrieves stored comment by its id
func (cs *CommentService) Comment(id uint) (*entity.Comment, []error) {
	usr, errs := cs.commentRepo.Comment(id)
	if len(errs) > 0 {
		return nil, errs
	}
	return usr, errs
}

// UpdateComment updates a given comment in the database
func (cs *CommentService) UpdateComment(user *entity.Comment) (*entity.Comment, []error) {
	usr, errs := cs.commentRepo.UpdateComment(user)
	if len(errs) > 0 {
		return nil, errs
	}
	return usr, errs
}

// DeleteComment deletes a given comment
func (cs *CommentService) DeleteComment(id uint) (*entity.Comment, []error) {
	user, errs := cs.commentRepo.DeleteComment(id)
	if len(errs) > 0 {
		return nil, errs
	}
	return user, errs
}

// StoreComment stores a given comment
func (cs *CommentService) StoreComment(comment *entity.Comment) (*entity.Comment, []error) {
	cmnt, errs := cs.commentRepo.StoreComment(comment)
	if len(errs) > 0 {
		return nil, errs
	}
	return cmnt, errs
}


